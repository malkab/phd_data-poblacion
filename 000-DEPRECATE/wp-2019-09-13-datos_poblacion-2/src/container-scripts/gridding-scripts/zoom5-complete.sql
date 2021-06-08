-- Full gridding of poblacion, zoom 5



begin;


-- Aggregation of variables by provincia, municipio, codigo
-- to zoom 5

create table poblacion_processing.grid_ieca_agg_zoom5 as
select

    row_number() over () as gid,

    b.gid as cell_gid,

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

    poblacion as poblacion_sc,

    provincia,
    catalog_provincias,
    municipio,
    catalog_municipios,
    codigo,
    catalog_seccion_censal,

    b.geom as geom

from
    poblacion_processing.grid_ieca_point_sc_catalogs a inner join
    context_grid.zoom5 b
    on st_contains(b.geom, a.geom)

group by
    cell_gid,
    provincia,
    catalog_provincias,
    municipio,
    catalog_municipios,
    codigo,
    catalog_seccion_censal,
    poblacion,
    b.geom;

create index grid_ieca_agg_zoom5_geom_gist
on poblacion_processing.grid_ieca_agg_zoom5
using gist(geom);



-- JSON data structure: provincia / municipio / seccion_censal / array
-- of timeline 2002, 2013, 2014, 2015, 2016, 2017

create table poblacion_processing.grid_ieca_agg_zoom5_json as
select

    cell_gid,

    (b.cell).grid_id,
    (b.cell).epsg,
    (b.cell).zoom,
    (b.cell).x,
    (b.cell).y,

    jsonb_build_object(

        'pob',

        jsonb_build_object(

            catalog_provincias,
            jsonb_build_object(

                catalog_municipios,
                jsonb_build_object(

                    catalog_seccion_censal,

                    jsonb_build_array(
                    
                        jsonb_build_object(

                            'pt',
                            pob_tot_2002,

                            'pm',
                            pob_m_2002,

                            'ph',
                            pob_h_2002,

                            '0015',
                            edad0015_2002,

                            '1664',
                            edad1664_2002,

                            '65',
                            edad65__2002,

                            'es',
                            esp_2002,

                            'sh',
                            ue15_2002,

                            'ma',
                            mag_2002,

                            'am',
                            ams_2002,

                            'ot',
                            otr_2002

                        ),


                        jsonb_build_object(

                            'pt',
                            pob_tot_2013,

                            'pm',
                            pob_m_2013,

                            'ph',
                            pob_h_2013,

                            '0015',
                            edad0015_2013,

                            '1664',
                            edad1664_2013,

                            '65',
                            edad65__2013,

                            'es',
                            esp_2013,

                            'sh',
                            ue15_2013,

                            'ma',
                            mag_2013,

                            'am',
                            ams_2013,

                            'ot',
                            otr_2013

                        ),


                        jsonb_build_object(

                            'pt',
                            pob_tot_2014,

                            'pm',
                            pob_m_2014,

                            'ph',
                            pob_h_2014,

                            '0015',
                            edad0015_2014,

                            '1664',
                            edad1664_2014,

                            '65',
                            edad65__2014,

                            'es',
                            esp_2014,

                            'sh',
                            ue15_2014,

                            'ma',
                            mag_2014,

                            'am',
                            ams_2014,

                            'ot',
                            otr_2014

                        ),


                        jsonb_build_object(

                            'pt',
                            pob_tot_2015,

                            'pm',
                            pob_m_2015,

                            'ph',
                            pob_h_2015,

                            '0015',
                            edad0015_2015,

                            '1664',
                            edad1664_2015,

                            '65',
                            edad65__2015,

                            'es',
                            esp_2015,

                            'sh',
                            ue15_2015,

                            'ma',
                            mag_2015,

                            'am',
                            ams_2015,

                            'ot',
                            otr_2015

                        ),


                        jsonb_build_object(

                            'pt',
                            pob_tot_2016,

                            'pm',
                            pob_m_2016,

                            'ph',
                            pob_h_2016,

                            '0015',
                            edad0015_2016,

                            '1664',
                            edad1664_2016,

                            '65',
                            edad65__2016,

                            'es',
                            esp_2016,

                            'sh',
                            ue15_2016,

                            'ma',
                            mag_2016,

                            'am',
                            ams_2016,

                            'ot',
                            otr_2016

                        ),


                        jsonb_build_object(

                            'pt',
                            pob_tot_2017,

                            'pm',
                            pob_m_2017,

                            'ph',
                            pob_h_2017,

                            '0015',
                            edad0015_2017,

                            '1664',
                            edad1664_2017,

                            '65',
                            edad65__2017,

                            'es',
                            esp_2017,

                            'sh',
                            ue15_2017,

                            'ma',
                            mag_2017,

                            'am',
                            ams_2017,

                            'ot',
                            otr_2017

                        )

                    )

                )

            )

        )
        
    ) as data

from
    poblacion_processing.grid_ieca_agg_zoom5 a inner join
    context_grid.zoom5 b
    on a.cell_gid = b.gid;

create index grid_ieca_agg_zoom5_json_cell_gid
on poblacion_processing.grid_ieca_agg_zoom5_json
using btree(cell_gid);



-- Write data into cells

select count(cell__insertbranch(
    (
        grid_id,
        epsg,
        zoom,
        x,
        y,
        data
    )::cell__cell
))
from poblacion_processing.grid_ieca_agg_zoom5_json;


commit;
