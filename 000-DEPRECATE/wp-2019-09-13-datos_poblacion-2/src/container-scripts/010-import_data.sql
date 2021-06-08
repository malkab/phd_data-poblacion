-- Import data

begin;


create schema poblacion;

create table poblacion.grid_ieca(

    grd_fixid varchar(22),
    municipio varchar(150),
    pob_tot_2002 integer,
    pob_tot_2013 integer,
    pob_tot_2014 integer,
    pob_tot_2015 integer,
    pob_tot_2016 integer,
    pob_tot_2017 integer,
    pob_m_2002 integer,
    pob_m_2013 integer,
    pob_m_2014 integer,
    pob_m_2015 integer,
    pob_m_2016 integer,
    pob_m_2017 integer,
    pob_h_2002 integer,
    pob_h_2013 integer,
    pob_h_2014 integer,
    pob_h_2015 integer,
    pob_h_2016 integer,
    pob_h_2017 integer,
    edad0015_2002 integer,
    edad0015_2013 integer,
    edad0015_2014 integer,
    edad0015_2015 integer,
    edad0015_2016 integer,
    edad0015_2017 integer,
    edad1664_2002 integer,
    edad1664_2013 integer,
    edad1664_2014 integer,
    edad1664_2015 integer,
    edad1664_2016 integer,
    edad1664_2017 integer,
    edad65__2002 integer,
    edad65__2013 integer,
    edad65__2014 integer,
    edad65__2015 integer,
    edad65__2016 integer,
    edad65__2017 integer,
    esp_2002 integer,
    esp_2013 integer,
    esp_2014 integer,
    esp_2015 integer,
    esp_2016 integer,
    esp_2017 integer,
    ue15_2002 integer,
    ue15_2013 integer,
    ue15_2014 integer,
    ue15_2015 integer,
    ue15_2016 integer,
    ue15_2017 integer,
    mag_2002 integer,
    mag_2013 integer,
    mag_2014 integer,
    mag_2015 integer,
    mag_2016 integer,
    mag_2017 integer,
    ams_2002 integer,
    ams_2013 integer,
    ams_2014 integer,
    ams_2015 integer,
    ams_2016 integer,
    ams_2017 integer,
    otr_2002 integer,
    otr_2013 integer,
    otr_2014 integer,
    otr_2015 integer,
    otr_2016 integer,
    otr_2017 integer,
    n integer,
    geom geometry("MultiPolygon", 3035)

);

create index grid_ieca_geom_gist
on poblacion.grid_ieca
using gist(geom);


\copy poblacion.grid_ieca from 'data/000-in/grid_ieca.csv' with csv header null '-'

commit;
