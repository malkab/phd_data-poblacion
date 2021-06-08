-- Población processing

begin;

create schema poblacion_processing;


-- Polygons to points in IECA cells

create table poblacion_processing.grid_ieca_point as
select
    
    row_number() over () as gid,

    pob_tot_2002,
    pob_tot_2013,
    pob_tot_2014,
    pob_tot_2015,
    pob_tot_2016,
    pob_tot_2017,
    pob_m_2002,
    pob_m_2013,
    pob_m_2014,
    pob_m_2015,
    pob_m_2016,
    pob_m_2017,
    pob_h_2002,
    pob_h_2013,
    pob_h_2014,
    pob_h_2015,
    pob_h_2016,
    pob_h_2017,
    edad0015_2002,
    edad0015_2013,
    edad0015_2014,
    edad0015_2015,
    edad0015_2016,
    edad0015_2017,
    edad1664_2002,
    edad1664_2013,
    edad1664_2014,
    edad1664_2015,
    edad1664_2016,
    edad1664_2017,
    edad65__2002,
    edad65__2013,
    edad65__2014,
    edad65__2015,
    edad65__2016,
    edad65__2017,
    esp_2002,
    esp_2013,
    esp_2014,
    esp_2015,
    esp_2016,
    esp_2017,
    ue15_2002,
    ue15_2013,
    ue15_2014,
    ue15_2015,
    ue15_2016,
    ue15_2017,
    mag_2002,
    mag_2013,
    mag_2014,
    mag_2015,
    mag_2016,
    mag_2017,
    ams_2002,
    ams_2013,
    ams_2014,
    ams_2015,
    ams_2016,
    ams_2017,
    otr_2002,
    otr_2013,
    otr_2014,
    otr_2015,
    otr_2016,
    otr_2017,
    n,
    st_centroid(geom) as geom

from

    poblacion.grid_ieca;


create index grid_ieca_point_geom_gist
on poblacion_processing.grid_ieca_point
using gist(geom);



-- Attach IECA points to Sección Censal with a proximity, because points
-- in the coast don't fall into a SC

create table poblacion_processing.grid_ieca_point_sc as
select distinct on (agid)
    a.gid as agid,
    b.gid as bgid,

    pob_tot_2002,
    pob_tot_2013,
    pob_tot_2014,
    pob_tot_2015,
    pob_tot_2016,
    pob_tot_2017,
    pob_m_2002,
    pob_m_2013,
    pob_m_2014,
    pob_m_2015,
    pob_m_2016,
    pob_m_2017,
    pob_h_2002,
    pob_h_2013,
    pob_h_2014,
    pob_h_2015,
    pob_h_2016,
    pob_h_2017,
    edad0015_2002,
    edad0015_2013,
    edad0015_2014,
    edad0015_2015,
    edad0015_2016,
    edad0015_2017,
    edad1664_2002,
    edad1664_2013,
    edad1664_2014,
    edad1664_2015,
    edad1664_2016,
    edad1664_2017,
    edad65__2002,
    edad65__2013,
    edad65__2014,
    edad65__2015,
    edad65__2016,
    edad65__2017,
    esp_2002,
    esp_2013,
    esp_2014,
    esp_2015,
    esp_2016,
    esp_2017,
    ue15_2002,
    ue15_2013,
    ue15_2014,
    ue15_2015,
    ue15_2016,
    ue15_2017,
    mag_2002,
    mag_2013,
    mag_2014,
    mag_2015,
    mag_2016,
    mag_2017,
    ams_2002,
    ams_2013,
    ams_2014,
    ams_2015,
    ams_2016,
    ams_2017,
    otr_2002,
    otr_2013,
    otr_2014,
    otr_2015,
    otr_2016,
    otr_2017,

    b.poblacion,
    b.codigo,
    b.municipio,
    b.provincia,

    st_distance(a.geom, b.geom) as d,

    a.geom
from
    poblacion_processing.grid_ieca_point a inner join
    context.seccion_censal b on
    st_dwithin(b.geom, a.geom, 1500)
order by agid, d;

create index grid_ieca_point_sc_geom_gist
on poblacion_processing.grid_ieca_point_sc
using gist(geom);



-- Materialize catalogs

create table poblacion_processing.catalog_provincias as
select *
from 
    jsonb_each_text((
        select 
            value -> 'forward' 
        from meta.celldsobject 
        where keeper_key like 'Keeper::Catalog::provincias'
    )
)
order by key;

alter table poblacion_processing.catalog_provincias
add constraint catalog_provincias_pkey
primary key(key);


create table poblacion_processing.catalog_municipios as
select *
from 
    jsonb_each_text((
        select 
            value -> 'forward' 
        from meta.celldsobject 
        where keeper_key like 'Keeper::Catalog::municipios'
    )
)
order by key;

alter table poblacion_processing.catalog_municipios
add constraint catalog_municipios_pkey
primary key(key);


create table poblacion_processing.catalog_seccion_censal as
select *
from 
    jsonb_each_text((
        select 
            value -> 'forward' 
        from meta.celldsobject 
        where keeper_key like 'Keeper::Catalog::seccion_censal'
    )
)
order by key;

alter table poblacion_processing.catalog_seccion_censal
add constraint catalog_seccion_censal_pkey
primary key(key);



-- Union of grid_ieca_point_sc with the catalogs

create table poblacion_processing.grid_ieca_point_sc_catalogs as
select

    agid,
    bgid,

    pob_tot_2002,
    pob_tot_2013,
    pob_tot_2014,
    pob_tot_2015,
    pob_tot_2016,
    pob_tot_2017,
    pob_m_2002,
    pob_m_2013,
    pob_m_2014,
    pob_m_2015,
    pob_m_2016,
    pob_m_2017,
    pob_h_2002,
    pob_h_2013,
    pob_h_2014,
    pob_h_2015,
    pob_h_2016,
    pob_h_2017,
    edad0015_2002,
    edad0015_2013,
    edad0015_2014,
    edad0015_2015,
    edad0015_2016,
    edad0015_2017,
    edad1664_2002,
    edad1664_2013,
    edad1664_2014,
    edad1664_2015,
    edad1664_2016,
    edad1664_2017,
    edad65__2002,
    edad65__2013,
    edad65__2014,
    edad65__2015,
    edad65__2016,
    edad65__2017,
    esp_2002,
    esp_2013,
    esp_2014,
    esp_2015,
    esp_2016,
    esp_2017,
    ue15_2002,
    ue15_2013,
    ue15_2014,
    ue15_2015,
    ue15_2016,
    ue15_2017,
    mag_2002,
    mag_2013,
    mag_2014,
    mag_2015,
    mag_2016,
    mag_2017,
    ams_2002,
    ams_2013,
    ams_2014,
    ams_2015,
    ams_2016,
    ams_2017,
    otr_2002,
    otr_2013,
    otr_2014,
    otr_2015,
    otr_2016,
    otr_2017,

    poblacion,

    provincia,
    b.value as catalog_provincias,
    municipio,
    c.value as catalog_municipios,
    codigo,
    d.value as catalog_seccion_censal,

    geom

from 
    poblacion_processing.grid_ieca_point_sc a inner join
    poblacion_processing.catalog_provincias b on
    a.provincia = b.key inner join
    poblacion_processing.catalog_municipios c on
    a.municipio = c.key inner join
    poblacion_processing.catalog_seccion_censal d on
    a.codigo = d.key;



commit;
