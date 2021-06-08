/*

    Grids the zoom 4 of population

*/


begin;



-- Drops the temp table, if exists

drop table if exists temp.pob_zoom4_gridding;


-- Creates the temp data

create table temp.pob_zoom4_gridding as

with a as (

select
    a.gid,

    sum(pob_tot_2002) as pt_02,
    sum(pob_tot_2013) as pt_13,
    sum(pob_tot_2014) as pt_14,
    sum(pob_tot_2015) as pt_15,
    sum(pob_tot_2016) as pt_16,
    sum(pob_tot_2017) as pt_17,

    sum(pob_m_2002) as pm_02,
    sum(pob_m_2013) as pm_13,
    sum(pob_m_2014) as pm_14,
    sum(pob_m_2015) as pm_15,
    sum(pob_m_2016) as pm_16,
    sum(pob_m_2017) as pm_17,

    sum(pob_h_2002) as ph_02,
    sum(pob_h_2013) as ph_13,
    sum(pob_h_2014) as ph_14,
    sum(pob_h_2015) as ph_15,
    sum(pob_h_2016) as ph_16,
    sum(pob_h_2017) as ph_17,

    sum(edad0015_2002) as e0015_02,
    sum(edad0015_2013) as e0015_13,
    sum(edad0015_2014) as e0015_14,
    sum(edad0015_2015) as e0015_15,
    sum(edad0015_2016) as e0015_16,
    sum(edad0015_2017) as e0015_17,

    sum(edad1664_2002) as e1664_02,
    sum(edad1664_2013) as e1664_13,
    sum(edad1664_2014) as e1664_14,
    sum(edad1664_2015) as e1664_15,
    sum(edad1664_2016) as e1664_16,
    sum(edad1664_2017) as e1664_17,

    sum(edad65__2002) as e65__02,
    sum(edad65__2013) as e65__13,
    sum(edad65__2014) as e65__14,
    sum(edad65__2015) as e65__15,
    sum(edad65__2016) as e65__16,
    sum(edad65__2017) as e65__17,

    sum(esp_2002) as es_02,
    sum(esp_2013) as es_13,
    sum(esp_2014) as es_14,
    sum(esp_2015) as es_15,
    sum(esp_2016) as es_16,
    sum(esp_2017) as es_17,

    sum(ue15_2002) as ue_02,
    sum(ue15_2013) as ue_13,
    sum(ue15_2014) as ue_14,
    sum(ue15_2015) as ue_15,
    sum(ue15_2016) as ue_16,
    sum(ue15_2017) as ue_17,

    sum(mag_2002) as ma_02,
    sum(mag_2013) as ma_13,
    sum(mag_2014) as ma_14,
    sum(mag_2015) as ma_15,
    sum(mag_2016) as ma_16,
    sum(mag_2017) as ma_17,

    sum(ams_2002) as am_02,
    sum(ams_2013) as am_13,
    sum(ams_2014) as am_14,
    sum(ams_2015) as am_15,
    sum(ams_2016) as am_16,
    sum(ams_2017) as am_17,

    sum(otr_2002) as ot_02,
    sum(otr_2013) as ot_13,
    sum(otr_2014) as ot_14,
    sum(otr_2015) as ot_15,
    sum(otr_2016) as ot_16,
    sum(otr_2017) as ot_17,

    a.cell as cell

from

    context_grid.zoom4 a inner join
    grid_ready.grid_ieca b on st_contains(a.geom, b.geom)

group by
    a.gid, a.cell

),

b as (

select 

    cell,

    jsonb_build_object(

        'pt_02', pt_02, 
        'pt_13', pt_13,
        'pt_14', pt_14,
        'pt_15', pt_15,
        'pt_16', pt_16,
        'pt_17', pt_17,

        'pm_02', pm_02,
        'pm_13', pm_13,
        'pm_14', pm_14,
        'pm_15', pm_15,
        'pm_16', pm_16,
        'pm_17', pm_17,

        'ph_02', ph_02,
        'ph_13', ph_13,
        'ph_14', ph_14,
        'ph_15', ph_15,
        'ph_16', ph_16,
        'ph_17', ph_17,

        'e0015_02', e0015_02,
        'e0015_13', e0015_13,
        'e0015_14', e0015_14,
        'e0015_15', e0015_15,
        'e0015_16', e0015_16,
        'e0015_17', e0015_17,

        'e1664_02', e1664_02, 
        'e1664_13', e1664_13, 
        'e1664_14', e1664_14, 
        'e1664_15', e1664_15, 
        'e1664_16', e1664_16, 
        'e1664_17', e1664_17, 

        'e65__02', e65__02,
        'e65__13', e65__13,
        'e65__14', e65__14,
        'e65__15', e65__15,
        'e65__16', e65__16,
        'e65__17', e65__17,

        'es_02', es_02,
        'es_13', es_13,
        'es_14', es_14,
        'es_15', es_15,
        'es_16', es_16,
        'es_17', es_17,

        'ue_02', ue_02,
        'ue_13', ue_13,
        'ue_14', ue_14,
        'ue_15', ue_15,
        'ue_16', ue_16,
        'ue_17', ue_17

    ) as dat0,

    jsonb_build_object(

        'ma_02', ma_02,
        'ma_13', ma_13,
        'ma_14', ma_14,
        'ma_15', ma_15,
        'ma_16', ma_16,
        'ma_17', ma_17,

        'am_02', am_02,
        'am_13', am_13,
        'am_14', am_14,
        'am_15', am_15,
        'am_16', am_16,
        'am_17', am_17,

        'ot_02', ot_02,
        'ot_13', ot_13,
        'ot_14', ot_14,
        'ot_15', ot_15,
        'ot_16', ot_16,
        'ot_17', ot_17
        
    ) as dat1

from a

)

select
    
    (cell).grid_id,
    (cell).epsg,
    (cell).zoom,
    (cell).x,
    (cell).y,
    jsonb_build_object('p', dat0) as dat0,
    jsonb_build_object('p', dat1) as dat1

from b
;


-- Merges the gridded info into data.data

select count(cell__setcell(
    (
        grid_id,
        epsg,
        zoom,
        x,
        y,
        dat1
    )::cell__cell
))
from temp.pob_zoom4_gridding;


select count(cell__setcell(
    (
        grid_id,
        epsg,
        zoom,
        x,
        y,
        dat0
    )::cell__cell
))
from temp.pob_zoom4_gridding;


-- Drops the temp data

drop table if exists temp.pob_zoom4_gridding;


commit;
