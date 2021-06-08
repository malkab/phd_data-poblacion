/**

  Produces clean poblacion_process data.

*/
begin;

create table poblacion_process.original_02 as
select
  grd_fixid as id,
  pob_tot::integer as ptot02,
  pob_m::integer as pm02,
  pob_h::integer as ph02,
  edad0015::integer as e001502,
  edad1664::integer as e166402,
  edad65_::integer as e6502,
  esp::integer as esp02,
  ue15::integer as ue1502,
  mag::integer as mag02,
  ams::integer as ams02,
  otr::integer as otr02,
  geom
from
  poblacion_process.mep02;

alter table poblacion_process.original_02
add constraint original_02_pkey
primary key(id);

create index original_02_geom_gist
on poblacion_process.original_02
using gist(geom);

create table poblacion_process.original_13 as
select
  grd_fixid as id,
  pob_tot::integer as ptot13,
  pob_m::integer as pm13,
  pob_h::integer as ph13,
  edad0015::integer as e001513,
  edad1664::integer as e166413,
  edad65_::integer as e6513,
  esp::integer as esp13,
  ue15::integer as ue1513,
  mag::integer as mag13,
  ams::integer as ams13,
  otr::integer as otr13,
  geom
from
  poblacion_process.mep13;

alter table poblacion_process.original_13
add constraint original_13_pkey
primary key(id);

create index original_13_geom_gist
on poblacion_process.original_13
using gist(geom);

create table poblacion_process.original_14 as
select
  grd_fixid as id,
  pob_tot::integer as ptot14,
  pob_m::integer as pm14,
  pob_h::integer as ph14,
  edad0015::integer as e001514,
  edad1664::integer as e166414,
  edad65_::integer as e6514,
  esp::integer as esp14,
  ue15::integer as ue1514,
  mag::integer as mag14,
  ams::integer as ams14,
  otr::integer as otr14,
  geom
from
  poblacion_process.mep14;

alter table poblacion_process.original_14
add constraint original_14_pkey
primary key(id);

create index original_14_geom_gist
on poblacion_process.original_14
using gist(geom);

create table poblacion_process.original_15 as
select
  grd_fixid as id,
  pob_tot::integer as ptot15,
  pob_m::integer as pm15,
  pob_h::integer as ph15,
  edad0015::integer as e001515,
  edad1664::integer as e166415,
  edad65_::integer as e6515,
  esp::integer as esp15,
  ue15::integer as ue1515,
  mag::integer as mag15,
  ams::integer as ams15,
  otr::integer as otr15,
  geom
from
  poblacion_process.mep15;

alter table poblacion_process.original_15
add constraint original_15_pkey
primary key(id);

create index original_15_geom_gist
on poblacion_process.original_15
using gist(geom);

create table poblacion_process.original_16 as
select
  grd_fixid as id,
  pob_tot::integer as ptot16,
  pob_m::integer as pm16,
  pob_h::integer as ph16,
  edad0015::integer as e001516,
  edad1664::integer as e166416,
  edad65_::integer as e6516,
  esp::integer as esp16,
  ue15::integer as ue1516,
  mag::integer as mag16,
  ams::integer as ams16,
  otr::integer as otr16,
  geom
from
  poblacion_process.mep16;

alter table poblacion_process.original_16
add constraint original_16_pkey
primary key(id);

create index original_16_geom_gist
on poblacion_process.original_16
using gist(geom);

create table poblacion_process.original_17 as
select
  grd_fixid as id,
  pob_tot::integer as ptot17,
  pob_m::integer as pm17,
  pob_h::integer as ph17,
  edad0015::integer as e001517,
  edad1664::integer as e166417,
  edad65_::integer as e6517,
  esp::integer as esp17,
  ue15::integer as ue1517,
  mag::integer as mag17,
  ams::integer as ams17,
  otr::integer as otr17,
  geom
from
  poblacion_process.mep17;

alter table poblacion_process.original_17
add constraint original_17_pkey
primary key(id);

create index original_17_geom_gist
on poblacion_process.original_17
using gist(geom);

create table poblacion_process.original_18 as
select
  grd_fixid as id,
  pob_tot::integer as ptot18,
  pob_m::integer as pm18,
  pob_h::integer as ph18,
  edad0015::integer as e001518,
  edad1664::integer as e166418,
  edad65_::integer as e6518,
  esp::integer as esp18,
  ue15::integer as ue1518,
  mag::integer as mag18,
  ams::integer as ams18,
  otr::integer as otr18,
  geom
from
  poblacion_process.mep18;

alter table poblacion_process.original_18
add constraint original_18_pkey
primary key(id);

create index original_18_geom_gist
on poblacion_process.original_18
using gist(geom);

/**

  Convert -1 (no data in Shapefiles) into null

*/
update poblacion_process.original_02 set
  ptot02 = null
where ptot02 = -1;

update poblacion_process.original_02 set
  pm02 = null
where pm02 = -1;

update poblacion_process.original_02 set
  ph02 = null
where ph02 = -1;

update poblacion_process.original_02 set
  e001502 = null
where e001502 = -1;

update poblacion_process.original_02 set
  e166402 = null
where e166402 = -1;

update poblacion_process.original_02 set
  e6502 = null
where e6502 = -1;

update poblacion_process.original_02 set
  esp02 = null
where esp02 = -1;

update poblacion_process.original_02 set
  ue1502 = null
where ue1502 = -1;

update poblacion_process.original_02 set
  mag02 = null
where mag02 = -1;

update poblacion_process.original_02 set
  ams02 = null
where ams02 = -1;

update poblacion_process.original_02 set
  otr02 = null
where otr02 = -1;

update poblacion_process.original_13 set
  ptot13 = null
where ptot13 = -1;

update poblacion_process.original_13 set
  pm13 = null
where pm13 = -1;

update poblacion_process.original_13 set
  ph13 = null
where ph13 = -1;

update poblacion_process.original_13 set
  e001513 = null
where e001513 = -1;

update poblacion_process.original_13 set
  e166413 = null
where e166413 = -1;

update poblacion_process.original_13 set
  e6513 = null
where e6513 = -1;

update poblacion_process.original_13 set
  esp13 = null
where esp13 = -1;

update poblacion_process.original_13 set
  ue1513 = null
where ue1513 = -1;

update poblacion_process.original_13 set
  mag13 = null
where mag13 = -1;

update poblacion_process.original_13 set
  ams13 = null
where ams13 = -1;

update poblacion_process.original_13 set
  otr13 = null
where otr13 = -1;

update poblacion_process.original_14 set
  ptot14 = null
where ptot14 = -1;

update poblacion_process.original_14 set
  pm14 = null
where pm14 = -1;

update poblacion_process.original_14 set
  ph14 = null
where ph14 = -1;

update poblacion_process.original_14 set
  e001514 = null
where e001514 = -1;

update poblacion_process.original_14 set
  e166414 = null
where e166414 = -1;

update poblacion_process.original_14 set
  e6514 = null
where e6514 = -1;

update poblacion_process.original_14 set
  esp14 = null
where esp14 = -1;

update poblacion_process.original_14 set
  ue1514 = null
where ue1514 = -1;

update poblacion_process.original_14 set
  mag14 = null
where mag14 = -1;

update poblacion_process.original_14 set
  ams14 = null
where ams14 = -1;

update poblacion_process.original_14 set
  otr14 = null
where otr14 = -1;

update poblacion_process.original_15 set
  ptot15 = null
where ptot15 = -1;

update poblacion_process.original_15 set
  pm15 = null
where pm15 = -1;

update poblacion_process.original_15 set
  ph15 = null
where ph15 = -1;

update poblacion_process.original_15 set
  e001515 = null
where e001515 = -1;

update poblacion_process.original_15 set
  e166415 = null
where e166415 = -1;

update poblacion_process.original_15 set
  e6515 = null
where e6515 = -1;

update poblacion_process.original_15 set
  esp15 = null
where esp15 = -1;

update poblacion_process.original_15 set
  ue1515 = null
where ue1515 = -1;

update poblacion_process.original_15 set
  mag15 = null
where mag15 = -1;

update poblacion_process.original_15 set
  ams15 = null
where ams15 = -1;

update poblacion_process.original_15 set
  otr15 = null
where otr15 = -1;

update poblacion_process.original_16 set
  ptot16 = null
where ptot16 = -1;

update poblacion_process.original_16 set
  pm16 = null
where pm16 = -1;

update poblacion_process.original_16 set
  ph16 = null
where ph16 = -1;

update poblacion_process.original_16 set
  e001516 = null
where e001516 = -1;

update poblacion_process.original_16 set
  e166416 = null
where e166416 = -1;

update poblacion_process.original_16 set
  e6516 = null
where e6516 = -1;

update poblacion_process.original_16 set
  esp16 = null
where esp16 = -1;

update poblacion_process.original_16 set
  ue1516 = null
where ue1516 = -1;

update poblacion_process.original_16 set
  mag16 = null
where mag16 = -1;

update poblacion_process.original_16 set
  ams16 = null
where ams16 = -1;

update poblacion_process.original_16 set
  otr16 = null
where otr16 = -1;

update poblacion_process.original_17 set
  ptot17 = null
where ptot17 = -1;

update poblacion_process.original_17 set
  pm17 = null
where pm17 = -1;

update poblacion_process.original_17 set
  ph17 = null
where ph17 = -1;

update poblacion_process.original_17 set
  e001517 = null
where e001517 = -1;

update poblacion_process.original_17 set
  e166417 = null
where e166417 = -1;

update poblacion_process.original_17 set
  e6517 = null
where e6517 = -1;

update poblacion_process.original_17 set
  esp17 = null
where esp17 = -1;

update poblacion_process.original_17 set
  ue1517 = null
where ue1517 = -1;

update poblacion_process.original_17 set
  mag17 = null
where mag17 = -1;

update poblacion_process.original_17 set
  ams17 = null
where ams17 = -1;

update poblacion_process.original_17 set
  otr17 = null
where otr17 = -1;

update poblacion_process.original_18 set
  ptot18 = null
where ptot18 = -1;

update poblacion_process.original_18 set
  pm18 = null
where pm18 = -1;

update poblacion_process.original_18 set
  ph18 = null
where ph18 = -1;

update poblacion_process.original_18 set
  e001518 = null
where e001518 = -1;

update poblacion_process.original_18 set
  e166418 = null
where e166418 = -1;

update poblacion_process.original_18 set
  e6518 = null
where e6518 = -1;

update poblacion_process.original_18 set
  esp18 = null
where esp18 = -1;

update poblacion_process.original_18 set
  ue1518 = null
where ue1518 = -1;

update poblacion_process.original_18 set
  mag18 = null
where mag18 = -1;

update poblacion_process.original_18 set
  ams18 = null
where ams18 = -1;

update poblacion_process.original_18 set
  otr18 = null
where otr18 = -1;

/**

  Drop cells with all data to null.

*/
delete from poblacion_process.original_02
where ptot02 is null and pm02 is null and ph02 is null and
  e001502 is null and e166402 is null and e6502 is null and
  esp02 is null and ue1502 is null and mag02 is null and
  ams02 is null and otr02 is null;

delete from poblacion_process.original_13
where ptot13 is null and pm13 is null and ph13 is null and
  e001513 is null and e166413 is null and e6513 is null and
  esp13 is null and ue1513 is null and mag13 is null and
  ams13 is null and otr13 is null;

delete from poblacion_process.original_14
where ptot14 is null and pm14 is null and ph14 is null and
  e001514 is null and e166414 is null and e6514 is null and
  esp14 is null and ue1514 is null and mag14 is null and
  ams14 is null and otr14 is null;

delete from poblacion_process.original_15
where ptot15 is null and pm15 is null and ph15 is null and
  e001515 is null and e166415 is null and e6515 is null and
  esp15 is null and ue1515 is null and mag15 is null and
  ams15 is null and otr15 is null;

delete from poblacion_process.original_16
where ptot16 is null and pm16 is null and ph16 is null and
  e001516 is null and e166416 is null and e6516 is null and
  esp16 is null and ue1516 is null and mag16 is null and
  ams16 is null and otr16 is null;

delete from poblacion_process.original_17
where ptot17 is null and pm17 is null and ph17 is null and
  e001517 is null and e166417 is null and e6517 is null and
  esp17 is null and ue1517 is null and mag17 is null and
  ams17 is null and otr17 is null;

delete from poblacion_process.original_18
where ptot18 is null and pm18 is null and ph18 is null and
  e001518 is null and e166418 is null and e6518 is null and
  esp18 is null and ue1518 is null and mag18 is null and
  ams18 is null and otr18 is null;

/**

  Union of all geoms in the poblacion_process tables. This is used to aggregate all data
  into a single table.

*/
create table poblacion_process.union_geom as
select id, st_setsrid(st_transform(geom, 3035), 3035) as geom
from poblacion_process.original_02
union
select id, st_setsrid(st_transform(geom, 3035), 3035) as geom
from poblacion_process.original_13
union
select id, st_setsrid(st_transform(geom, 3035), 3035) as geom
from poblacion_process.original_14
union
select id, st_setsrid(st_transform(geom, 3035), 3035) as geom
from poblacion_process.original_15
union
select id, st_setsrid(st_transform(geom, 3035), 3035) as geom
from poblacion_process.original_16
union
select id, st_setsrid(st_transform(geom, 3035), 3035) as geom
from poblacion_process.original_17
union
select id, st_setsrid(st_transform(geom, 3035), 3035) as geom
from poblacion_process.original_18;

alter table poblacion_process.union_geom
add constraint union_geom_pkey
primary key(id);

create index union_geom_gist
on poblacion_process.union_geom
using gist(geom);

/**

  Calculate proximity.

*/
create table poblacion_process.cercania_provincia as
select distinct on (g.id)
  g.id,
  p.provincia,
  st_distance(st_centroid(g.geom), p.geom) as d,
  st_centroid(g.geom) as geom_centroid,
  g.geom
from
  poblacion_process.union_geom g inner join
  context.provincia p on st_dwithin(st_centroid(g.geom), p.geom, 125)
order by g.id, d;

create table poblacion_process.cercania_municipio as
select distinct on (g.id)
  g.id,
  p.municipio,
  st_distance(st_centroid(g.geom), p.geom) as d,
  st_centroid(g.geom) as geom_centroid,
  g.geom
from
  poblacion_process.union_geom g inner join
  context.municipio p on st_dwithin(st_centroid(g.geom), p.geom, 125)
order by g.id, d;

create table poblacion_process.cercania_nucleo_poblacion as
select distinct on (g.id)
  g.id,
  p.nombre_pob,
  p.nivel,
  st_distance(st_centroid(g.geom), p.geom) as d,
  st_centroid(g.geom) as geom_centroid,
  g.geom
from
  poblacion_process.union_geom g inner join
  context.nucleo_poblacion p on st_dwithin(st_centroid(g.geom), p.geom, 125)
order by g.id, d;

create table poblacion_process.cercania_seccion_censal as
select distinct on (g.id)
  g.id,
  p.codigo,
  st_distance(st_centroid(g.geom), p.geom) as d,
  st_centroid(g.geom) as geom_centroid,
  g.geom
from
  poblacion_process.union_geom g inner join
  context.seccion_censal p on st_dwithin(st_centroid(g.geom), p.geom, 125)
order by g.id, d;

/**

  Final population aggregated table.

*/
create table poblacion.poblacion as
select
  g.id,

  ptot02,
  pm02,
  ph02,
  e001502,
  e166402,
  e6502,
  esp02,
  ue1502,
  mag02,
  ams02,
  otr02,

  ptot13,
  pm13,
  ph13,
  e001513,
  e166413,
  e6513,
  esp13,
  ue1513,
  mag13,
  ams13,
  otr13,

  ptot14,
  pm14,
  ph14,
  e001514,
  e166414,
  e6514,
  esp14,
  ue1514,
  mag14,
  ams14,
  otr14,

  ptot15,
  pm15,
  ph15,
  e001515,
  e166415,
  e6515,
  esp15,
  ue1515,
  mag15,
  ams15,
  otr15,

  ptot16,
  pm16,
  ph16,
  e001516,
  e166416,
  e6516,
  esp16,
  ue1516,
  mag16,
  ams16,
  otr16,

  ptot17,
  pm17,
  ph17,
  e001517,
  e166417,
  e6517,
  esp17,
  ue1517,
  mag17,
  ams17,
  otr17,

  ptot18,
  pm18,
  ph18,
  e001518,
  e166418,
  e6518,
  esp18,
  ue1518,
  mag18,
  ams18,
  otr18,

  cp.provincia,
  cm.municipio,
  co.nombre_pob as nuc_pob,
  co.nivel as nuc_pob_nivel,
  cs.codigo as sc_codigo,

  st_setsrid(st_transform(g.geom, 3035), 3035) as geom_cell,
  st_setsrid(st_transform(st_centroid(g.geom), 3035), 3035) as geom
from
  poblacion_process.union_geom g left join
  poblacion_process.original_02 m02 on g.id = m02.id left join
  poblacion_process.original_13 m13 on g.id = m13.id left join
  poblacion_process.original_14 m14 on g.id = m14.id left join
  poblacion_process.original_15 m15 on g.id = m15.id left join
  poblacion_process.original_16 m16 on g.id = m16.id left join
  poblacion_process.original_17 m17 on g.id = m17.id left join
  poblacion_process.original_18 m18 on g.id = m18.id left join
  poblacion_process.cercania_provincia cp on g.id = cp.id left join
  poblacion_process.cercania_municipio cm on g.id = cm.id left join
  poblacion_process.cercania_nucleo_poblacion co on g.id = co.id left join
  poblacion_process.cercania_seccion_censal cs on g.id = cs.id;

alter table poblacion.poblacion
add constraint poblacion_pkey
primary key(id);

create index poblacion_geom_gist
on poblacion.poblacion
using gist(geom);

create index poblacion_geom_cell_gist
on poblacion.poblacion
using gist(geom_cell);

commit;
