/*

    Process population raw data as provided by IECA.

*/

\o /dev/null

begin;

drop schema if exists process cascade;

create schema process;

-- Process centroids of original cells

create table process.centroids as 
select
    gid,
    gidmp,
    grd_fixid ,
    grd_floaid,
    grd_inspir,
    municipio,
    cmun,
    nota,
    pob_tot,
    pob_m,
    pob_h,
    edad0015,
    edad1664,
    edad65_,
    esp,
    ue15,
    mag,
    ams,
    otr,
    afil_ss,
    afil_ss_m,
    afil_ss_h,
    afil_ss_a,
    afil_ss_p,
    penc,
    penc_m,
    penc_h,
    pencjub,
    pencviu,
    pencjyv,
    pencinc,
    pencotr,
    pencjub_mi,
    pencviu_mi,
    pencjyv_mi,
    pencinc_mi,
    pencotr_mi,
    st_centroid(st_transform(geom, 3035)) as geom
from
    input.pop;

create index pop_geom_gist
on process.centroids
using gist(geom);


-- Cell collision
-- CHANGE HERE THE ZOOM

create table process.cells as
with cells as (
    select distinct
        cell__getcoverage('eu-grid', 6, geom) as cell
    from
        process.centroids
)
select
    cell,
    cell__cellgeom(cell) as geom
from cells;

create index cells_geom_gist
on process.cells
using gist(geom);



/*

    Indicator calculation

*/

select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('total', sum(pob_tot)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pob_tot<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('mujeres', sum(pob_m)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pob_m<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('hombres', sum(pob_h)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pob_h<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('edad0015', sum(edad0015)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    edad0015<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('edad1664', sum(edad1664)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    edad1664<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('edad65_', sum(edad65_)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    edad65_<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('espanyoles', sum(esp)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    esp<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('ue15', sum(ue15)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    ue15<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('magreb', sum(mag)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    mag<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('america', sum(ams)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    ams<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('otros', sum(otr)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    otr<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('afil_ss', sum(afil_ss)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    afil_ss<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('afil_ss_m', sum(afil_ss_m)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    afil_ss_m<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('afil_ss_h', sum(afil_ss_h)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    afil_ss_h<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('afil_ss_a', sum(afil_ss_a)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    afil_ss_a<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('afil_ss_p', sum(afil_ss_p)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    afil_ss_p<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('penc', sum(penc)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    penc<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('penc_m', sum(penc_m)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    penc_m<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('penc_h', sum(penc_h)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    penc_h<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencjub', sum(pencjub)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencjub<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencviu', sum(pencviu)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencviu<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencjyv', sum(pencjyv)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencjyv<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencinc', sum(pencinc)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencinc<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencotr', sum(pencotr)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencotr<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencjub_mi', sum(pencjub_mi)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencjub_mi<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencviu_mi', sum(pencviu_mi)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencviu_mi<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencjyv_mi', sum(pencjyv_mi)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencjyv_mi<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencinc_mi', sum(pencinc_mi)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencinc_mi<>-1
group by
    b.cell, b.geom;


select cell__insertbranch(
    (
        (b.cell).grid_id, (b.cell).epsg, 
        (b.cell).zoom, (b.cell).x, (b.cell).y,
        jsonb_build_object('poblacion', 
            jsonb_build_object('pencotr_mi', sum(pencotr_mi)))
    )::cell__cell
)
from
    process.centroids a inner join
    process.cells b on
    st_contains(b.geom, a .geom)
where
    pencotr_mi<>-1
group by
    b.cell, b.geom;


commit;


\o
