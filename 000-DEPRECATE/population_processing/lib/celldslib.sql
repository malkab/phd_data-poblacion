/*

    cellgridlib

    A library to assist in the gridding process of geographic layers.

*/

/*

    Cell type.

*/

begin;

drop type if exists cell__cell cascade;

create type cell__cell as (
    grid_id varchar(20),
    epsg integer,
    zoom integer,
    x bigint,
    y bigint,
    data jsonb
);

commit;


/*

    The meta schema.

*/

begin;

create schema meta;

create table meta.grid(
    id varchar(20),
    origin geometry,
    resolutions jsonb
);

alter table meta.grid
add constraint grid_pkey
primary key(id);

create index grid_resolutions_gin
on meta.grid
using gin(resolutions);



-- JSON schemas

create table meta.schemas(
    grid_id varchar(20),
    root varchar(20),
    json_schema jsonb
);

alter table meta.schemas
add constraint schemas_pkey
primary key(grid_id, json_schema);

create index schemas_gin
on meta.schemas
using gin(json_schema);



-- meta.language

create table meta.language(
    language_id varchar(2),
    name varchar(50)
);

alter table meta.language
add constraint language_pkey
primary key(language_id);


-- Foreign keys

alter table meta.schemas
add constraint schemas_grid_fkey
foreign key (grid_id) references meta.grid(id);


commit;



/*

    The data schema.

*/

begin;

-- Schema
create schema data;


-- Main data table
create table data.data(
    grid_id varchar(20),
    epsg integer,
    zoom integer,
    x bigint,
    y bigint,
    data jsonb,
    geom geometry(POLYGON),
    primary key(grid_id, zoom, x, y)
);

create index data_grid_id_btree
on data.data
using btree(grid_id);

create index data_zoom_btree
on data.data
using btree(zoom);

create index data_x_btree
on data.data
using btree(x);

create index data_y_btree
on data.data
using btree(y);

create index data_data_gin
on data.data
using gin(data);

create index data_geom_gist
on data.data
using gist(geom);


-- Foreign keys

alter table data.data
add constraint data_grid_fkey
foreign key (grid_id) references meta.grid(id);


-- Bulk data table, for the foreign data wrapper loader

create table data.bulk_load(
    cell cell__cell
);


/*

    View to debug JSON output in QGIS

*/

create or replace view data.data_qgis as
select
    grid_id,
    epsg,
    zoom,
    x, y,
    data::varchar as data,
    geom
from
    data.data
order by zoom;


commit;



/*

    The library code.

*/

begin;


/*

    Returns the SRS a grid system is defined on.

    varchar _grid_id: Grid's ID to return the SRS.

    integer return: Grid's SRS EPSG code.

*/

create or replace function public.cell__getgridsrs(
    _grid_id varchar(20)
) returns integer as
$$
    select st_srid(origin)
    from meta.grid
    where id=_grid_id;
$$
language sql;



/*

    Registers a new grid.

    varchar _id: Grid ID.
    geometry _origin: A point defining the origin of the grid.
    jsonb resolutions: Resolution zoom levels.

*/

create or replace function public.cell__registergrid(
    _id varchar(20),
    _origin geometry,
    _resolutions jsonb
) returns void as
$$
    insert into meta.grid values(
        _id, _origin, _resolutions
    );
$$
language sql;



/*

    Returns the grid size in a given zoom.

    varchar _grid_id: Grid ID.
    integer _zoom: Zoom level to examine.

    float return: The size of cells at the given zoom level.

*/

create or replace function public.cell__getgridsize(
    _grid_id varchar(20),
    _zoom integer
) returns float as
$$
    select (resolutions -> _zoom::varchar ->> 'size')::float
    from meta.grid
    where id = _grid_id;
$$
language sql;



/*

    Returns a grid origin point.

    varchar _grid_id: Grid ID.
    
    geometry return: The point of origin.

*/

create or replace function public.cell__getgridorigin(
    _grid_id varchar(20)
) returns geometry as
$$
    select origin
    from meta.grid
    where id = _grid_id;
$$
language sql;



/*

    Returns the geom of a cell__cell.

    cell__cell _cell: The cell to compute the geometry from.

    geometry return: The computed geometry.

*/

create or replace function public.cell__cellgeom(
    _cell cell__cell
) returns geometry as
$$

    select
        st_makeenvelope(
            st_x(gridorigin) + ((_cell).x * gridsize),
            st_y(gridorigin) + ((_cell).y * gridsize),
            st_x(gridorigin) + (((_cell).x + 1) * gridsize),
            st_y(gridorigin) + (((_cell).y + 1) * gridsize),
            (_cell).epsg)
    from 
        cell__getgridorigin((_cell).grid_id) as gridorigin,
        cell__getgridsize((_cell).grid_id, (_cell).zoom) as gridsize;

$$
language sql;



/*

    Returns the cell a point is on.

    varchar _grid_id: The grid ID.
    integer _zoom: The zoom to compute the cell.
    geometry _point: The target point.

    cell__cell return: The colliding cell.

*/

create or replace function public.cell__cellonpoint(
    _grid_id varchar(20),
    _zoom integer,
    _point geometry
) returns cell__cell as
$$

    select (   
        _grid_id,
        srs,
        _zoom,
        floor((st_x(ppoint)-st_x(gridorigin)) / gridsize),
        floor((st_y(ppoint)-st_y(gridorigin)) / gridsize),
        '{}'::jsonb)::cell__cell
    from
        cell__getgridsrs(_grid_id) as srs,
        st_transform(_point, srs) as ppoint,
        cell__getgridsize(_grid_id, _zoom) as gridsize,
        cell__getgridorigin(_grid_id) as gridorigin

$$
language sql;



/*

    Returns all cells that covers the BBOX of a geometry.

    varchar _grid_id: The grid ID.
    integer _zoom: The target zoom.
    geometry _geom: The geometry.

    setof cell__cell return: The colliding cells.

*/

create or replace function cell__getbboxcoverage(
    _grid_id varchar(20),
    _zoom integer,
    _geom geometry
) returns setof cell__cell as
$$

    select
        (_grid_id, srid, _zoom, sx, sy, '{}'::jsonb)::cell__cell
    from
        cell__getgridsrs(_grid_id) as srid,
        st_envelope(_geom) as env,
        cell__cellonpoint(_grid_id, _zoom, 
            st_setsrid(st_makepoint(st_xmin(env), st_ymin(env)), srid)) as mincell,
        cell__cellonpoint(_grid_id, _zoom, 
            st_setsrid(st_makepoint(st_xmax(env), st_ymax(env)), srid)) as maxcell,
        generate_series(mincell.x, maxcell.x) as sx,
        generate_series(mincell.y, maxcell.y) as sy;

$$
language sql;



/*

    Returns all cells that covers a geometry.

    varchar _grid_id: The grid ID.
    integer _zoom: The target zoom.
    geometry _geom: The target geometry.

    setof cell__cell return: The colliding cells.

*/

create or replace function cell__getcoverage(
    _grid_id varchar(20),
    _zoom integer,
    _geom geometry
) returns setof cell__cell as
$$

    select distinct
        (a.*)::cell__cell
    from
        cell__getbboxcoverage(_grid_id, _zoom, _geom) a inner join
        (select _geom as geom) b on
        st_intersects(cell__cellgeom(a), b.geom);

$$
language sql;



/*

    Builds a new JSON branch on an existing JSONB.

    This function makes a new branch to grow in an existing JSONB.
    The first argument is the JSONB to be modified, the second, the
    new branch. Branches must follow the following convention:
    
        '{"a": {"b": {"c": 343}}}'
    
    that is, must be a sequence of nested keys, with only a single 
    child, up to a final scalar data.

    This function won't overwrite an existing branch.

    jsonb _jsonb: The JSON to write upon.
    jsonb _jsonb_new: The new branch to write.

    jsonb return: The composed JSON.

*/

create or replace function public.cell__buildbranch(
    _jsonb jsonb,
    _jsonb_new jsonb
) returns jsonb as
$$
declare
    _key text;
    _value jsonb;
    _keys text[];
begin

    -- Initialization
    _keys = array[]::text[];

    -- Main loop
    loop

        _key = jsonb_object_keys(_jsonb_new);
        _keys = _keys || _key;
        _value = _jsonb_new -> _key;
        
        -- If route doesn't exist, create it and exit
        if _jsonb #> _keys is null then
            _jsonb = jsonb_set(_jsonb, _keys, _value);
            exit;
        end if;

        -- Iterate to next element
        _jsonb_new = _value;

        -- Safeguard to exit in case final element is reached 
        -- and element already existed
        exit when jsonb_typeof(_value)<>'object';

    end loop;

    return _jsonb;

end;
$$
language plpgsql;



/*

    Inserts a new JSON branch on an existing cell.

    This function makes a new branch to grow in a cell's data.
    Argument is a cell with the same definition as the cell intended
    to be modified, whose JSONB data is the definition of the new 
    branch.

    This function won't overwrite an existing branch.

    cell__cell _cell: The cell containing the new JSON payload.

*/

create or replace function public.cell__insertbranch(
    _cell cell__cell
) returns void as
$$

    insert into data.data as d
    values(
        (_cell).grid_id,
        (_cell).epsg,
        (_cell).zoom,
        (_cell).x,
        (_cell).y,
        (_cell).data,
        cell__cellgeom(_cell)
    ) on conflict(grid_id, zoom, x, y) do update
    set data = cell__buildbranch(d.data, (_cell).data)
    where d.grid_id=d.grid_id and d.zoom=d.zoom and d.x=d.x and d.y=d.y;

$$
language sql;



/*

    cell__merge

    Merges a cell into data.data, or inserts a new indicator root if the cell exists and the new cell got new indicators in its data field. If the target indicator root exists, it is overwritten with the new value. Check cell__insertbranch to merge JSON branches into existing indicator roots.

    cell__cell _cell: Cell with the JSON payload to merge.

*/

create or replace function public.cell__merge(
    _cell cell__cell
) returns void as
$$

    insert into data.data as d
    values(
        (_cell).grid_id,
        (_cell).epsg,
        (_cell).zoom,
        (_cell).x,
        (_cell).y,
        (_cell).data,
        cell__cellgeom(_cell)
    ) on conflict(grid_id, zoom, x, y) do update
    set data = d.data || (_cell).data
    where d.grid_id=d.grid_id and d.zoom=d.zoom and d.x=d.x and d.y=d.y;

$$
language sql;



commit;