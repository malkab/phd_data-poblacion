/*

    Establish a foreign data wrapper to the main node to pass 
    gridding partial results.

*/

begin;

-- Configure FDW

create extension if not exists postgres_fdw;

create server if not exists cellds_main 
foreign data wrapper postgres_fdw
options (host 'mmalonso.fgh.us.es', dbname 'cellds', port '7000');

create user mapping if not exists
for postgres
server cellds_main
options(user 'postgres', password 'postgres');

create foreign table data.bulk_load_main (
    cell cell__cell
)
server cellds_main
options (schema_name 'data', table_name 'bulk_load');


-- Bulk load

insert into data.bulk_load_main
select 
    (
        grid_id,
        epsg,
        zoom,
        x, y,
        data
    )::cell__cell
from
    data.data;


-- Drop FDW

drop server cellds_main cascade;


commit;