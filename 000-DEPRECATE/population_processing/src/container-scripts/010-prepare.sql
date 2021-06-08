-- Prepares the imported data to create the big table

begin;


create table temp.grid_ieca_00 as
select distinct
    coalesce(
        a.grd_fixid, 
        b.grd_fixid,
        c.grd_fixid, 
        d.grd_fixid,
        e.grd_fixid, 
        f.grd_fixid
    ) as grd_fixid,

    coalesce(
        a.municipio, 
        b.municipio,
        c.municipio, 
        d.municipio,
        e.municipio, 
        f.municipio
    ) as municipio,

    case
        when a.pob_tot = -1 then null
        else a.pob_tot
    end as pob_tot_2002,

    case
        when b.pob_tot = -1 then null
        else b.pob_tot
    end as pob_tot_2013,

    case
        when c.pob_tot = -1 then null
        else c.pob_tot
    end as pob_tot_2014,

    case
        when d.pob_tot = -1 then null
        else d.pob_tot
    end as pob_tot_2015,

    case
        when e.pob_tot = -1 then null
        else e.pob_tot
    end as pob_tot_2016,

    case
        when f.pob_tot = -1 then null
        else f.pob_tot
    end as pob_tot_2017,



    case
        when a.pob_m = -1 then null
        else a.pob_m
    end as pob_m_2002,

    case
        when b.pob_m = -1 then null
        else b.pob_m
    end as pob_m_2013,

    case
        when c.pob_m = -1 then null
        else c.pob_m
    end as pob_m_2014,

    case
        when d.pob_m = -1 then null
        else d.pob_m
    end as pob_m_2015,

    case
        when e.pob_m = -1 then null
        else e.pob_m
    end as pob_m_2016,

    case
        when f.pob_m = -1 then null
        else f.pob_m
    end as pob_m_2017,



    case
        when a.pob_h = -1 then null
        else a.pob_h
    end as pob_h_2002,

    case
        when b.pob_h = -1 then null
        else b.pob_h
    end as pob_h_2013,

    case
        when c.pob_h = -1 then null
        else c.pob_h
    end as pob_h_2014,

    case
        when d.pob_h = -1 then null
        else d.pob_h
    end as pob_h_2015,

    case
        when e.pob_h = -1 then null
        else e.pob_h
    end as pob_h_2016,

    case
        when f.pob_h = -1 then null
        else f.pob_h
    end as pob_h_2017,



    case
        when a.edad0015 = -1 then null
        else a.edad0015
    end as edad0015_2002,

    case
        when b.edad0015 = -1 then null
        else b.edad0015
    end as edad0015_2013,

    case
        when c.edad0015 = -1 then null
        else c.edad0015
    end as edad0015_2014,

    case
        when d.edad0015 = -1 then null
        else d.edad0015
    end as edad0015_2015,

    case
        when e.edad0015 = -1 then null
        else e.edad0015
    end as edad0015_2016,

    case
        when f.edad0015 = -1 then null
        else f.edad0015
    end as edad0015_2017,



    case
        when a.edad1664 = -1 then null
        else a.edad1664
    end as edad1664_2002,

    case
        when b.edad1664 = -1 then null
        else b.edad1664
    end as edad1664_2013,

    case
        when c.edad1664 = -1 then null
        else c.edad1664
    end as edad1664_2014,

    case
        when d.edad1664 = -1 then null
        else d.edad1664
    end as edad1664_2015,

    case
        when e.edad1664 = -1 then null
        else e.edad1664
    end as edad1664_2016,

    case
        when f.edad1664 = -1 then null
        else f.edad1664
    end as edad1664_2017,



    case
        when a.edad65_ = -1 then null
        else a.edad65_
    end as edad65__2002,

    case
        when b.edad65_ = -1 then null
        else b.edad65_
    end as edad65__2013,

    case
        when c.edad65_ = -1 then null
        else c.edad65_
    end as edad65__2014,

    case
        when d.edad65_ = -1 then null
        else d.edad65_
    end as edad65__2015,

    case
        when e.edad65_ = -1 then null
        else e.edad65_
    end as edad65__2016,

    case
        when f.edad65_ = -1 then null
        else f.edad65_
    end as edad65__2017,



    case
        when a.esp = -1 then null
        else a.esp
    end as esp_2002,

    case
        when b.esp = -1 then null
        else b.esp
    end as esp_2013,

    case
        when c.esp = -1 then null
        else c.esp
    end as esp_2014,

    case
        when d.esp = -1 then null
        else d.esp
    end as esp_2015,

    case
        when e.esp = -1 then null
        else e.esp
    end as esp_2016,

    case
        when f.esp = -1 then null
        else f.esp
    end as esp_2017,



    case
        when a.ue15 = -1 then null
        else a.ue15
    end as ue15_2002,

    case
        when b.ue15 = -1 then null
        else b.ue15
    end as ue15_2013,

    case
        when c.ue15 = -1 then null
        else c.ue15
    end as ue15_2014,

    case
        when d.ue15 = -1 then null
        else d.ue15
    end as ue15_2015,

    case
        when e.ue15 = -1 then null
        else e.ue15
    end as ue15_2016,

    case
        when f.ue15 = -1 then null
        else f.ue15
    end as ue15_2017,



    case
        when a.mag = -1 then null
        else a.mag
    end as mag_2002,

    case
        when b.mag = -1 then null
        else b.mag
    end as mag_2013,

    case
        when c.mag = -1 then null
        else c.mag
    end as mag_2014,

    case
        when d.mag = -1 then null
        else d.mag
    end as mag_2015,

    case
        when e.mag = -1 then null
        else e.mag
    end as mag_2016,

    case
        when f.mag = -1 then null
        else f.mag
    end as mag_2017,


    case
        when a.ams = -1 then null
        else a.ams
    end as ams_2002,

    case
        when b.ams = -1 then null
        else b.ams
    end as ams_2013,

    case
        when c.ams = -1 then null
        else c.ams
    end as ams_2014,

    case
        when d.ams = -1 then null
        else d.ams
    end as ams_2015,

    case
        when e.ams = -1 then null
        else e.ams
    end as ams_2016,

    case
        when f.ams = -1 then null
        else f.ams
    end as ams_2017,



    case
        when a.otr = -1 then null
        else a.otr
    end as otr_2002,

    case
        when b.otr = -1 then null
        else b.otr
    end as otr_2013,

    case
        when c.otr = -1 then null
        else c.otr
    end as otr_2014,

    case
        when d.otr = -1 then null
        else d.otr
    end as otr_2015,

    case
        when e.otr = -1 then null
        else e.otr
    end as otr_2016,

    case
        when f.otr = -1 then null
        else f.otr
    end as otr_2017,



    st_transform(st_centroid(
        coalesce(
            a.geom, 
            b.geom,
            c.geom, 
            d.geom,
            e.geom, 
            f.geom
        )), 3035
    ) as geom

from
    import.mep02_250m a full outer join
    import.mep13_250m b on a.grd_fixid = b.grd_fixid full outer join
    import.mep14_250m c on a.grd_fixid = c.grd_fixid full outer join
    import.mep15_250m d on a.grd_fixid = d.grd_fixid full outer join
    import.mep16_250m e on a.grd_fixid = e.grd_fixid full outer join
    import.mep17_250m f on a.grd_fixid = f.grd_fixid
;


-- Final table

create table grid_ready.grid_ieca as
select

    grd_fixid,

    municipio,

    sum(pob_tot_2002) as pob_tot_2002,
    sum(pob_tot_2013) as pob_tot_2013,
    sum(pob_tot_2014) as pob_tot_2014,
    sum(pob_tot_2015) as pob_tot_2015,
    sum(pob_tot_2016) as pob_tot_2016,
    sum(pob_tot_2017) as pob_tot_2017,

    sum(pob_m_2002) as pob_m_2002,
    sum(pob_m_2013) as pob_m_2013,
    sum(pob_m_2014) as pob_m_2014,
    sum(pob_m_2015) as pob_m_2015,
    sum(pob_m_2016) as pob_m_2016,
    sum(pob_m_2017) as pob_m_2017,

    sum(pob_h_2002) as pob_h_2002,
    sum(pob_h_2013) as pob_h_2013,
    sum(pob_h_2014) as pob_h_2014,
    sum(pob_h_2015) as pob_h_2015,
    sum(pob_h_2016) as pob_h_2016,
    sum(pob_h_2017) as pob_h_2017,

    sum(edad0015_2002) as edad0015_2002,
    sum(edad0015_2013) as edad0015_2013,
    sum(edad0015_2014) as edad0015_2014,
    sum(edad0015_2015) as edad0015_2015,
    sum(edad0015_2016) as edad0015_2016,
    sum(edad0015_2017) as edad0015_2017,

    sum(edad1664_2002) as edad1664_2002,
    sum(edad1664_2013) as edad1664_2013,
    sum(edad1664_2014) as edad1664_2014,
    sum(edad1664_2015) as edad1664_2015,
    sum(edad1664_2016) as edad1664_2016,
    sum(edad1664_2017) as edad1664_2017,

    sum(edad65__2002) as edad65__2002,
    sum(edad65__2013) as edad65__2013,
    sum(edad65__2014) as edad65__2014,
    sum(edad65__2015) as edad65__2015,
    sum(edad65__2016) as edad65__2016,
    sum(edad65__2017) as edad65__2017,

    sum(esp_2002) as esp_2002,
    sum(esp_2013) as esp_2013,
    sum(esp_2014) as esp_2014,
    sum(esp_2015) as esp_2015,
    sum(esp_2016) as esp_2016,
    sum(esp_2017) as esp_2017,

    sum(ue15_2002) as ue15_2002,
    sum(ue15_2013) as ue15_2013,
    sum(ue15_2014) as ue15_2014,
    sum(ue15_2015) as ue15_2015,
    sum(ue15_2016) as ue15_2016,
    sum(ue15_2017) as ue15_2017,

    sum(mag_2002) as mag_2002,
    sum(mag_2013) as mag_2013,
    sum(mag_2014) as mag_2014,
    sum(mag_2015) as mag_2015,
    sum(mag_2016) as mag_2016,
    sum(mag_2017) as mag_2017,

    sum(ams_2002) as ams_2002,
    sum(ams_2013) as ams_2013,
    sum(ams_2014) as ams_2014,
    sum(ams_2015) as ams_2015,
    sum(ams_2016) as ams_2016,
    sum(ams_2017) as ams_2017,

    sum(otr_2002) as otr_2002,
    sum(otr_2013) as otr_2013,
    sum(otr_2014) as otr_2014,
    sum(otr_2015) as otr_2015,
    sum(otr_2016) as otr_2016,
    sum(otr_2017) as otr_2017,

    count(*) as n,

    geom
from 
    temp.grid_ieca_00
group by
    grd_fixid, geom, municipio
;

create index grid_ieca_geom_gist
on grid_ready.grid_ieca
using gist(geom);


-- Clean up

drop table temp.grid_ieca_00;


commit;
