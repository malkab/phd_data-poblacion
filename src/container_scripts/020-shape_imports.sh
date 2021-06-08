#!/bin/bash

# Imports nucleos_poblacion shapefile

PGCLIENTENCODING=UTF-8 ogr2ogr \
  -f "PostgreSQL" PG:"host=${MLKC_POBLACION_HOST} user=postgres dbname=cell_raw_data password=${MLKC_POBLACION_POSTGIS_PASSWORD} port=${MLKC_POBLACION_PG_EXTERNAL_PORT}" \
  -a_srs "EPSG:25830" -lco SCHEMA=poblacion_process -lco FID=gid \
  -lco OVERWRITE=YES -nln mec17 \
  -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
  -lco PRECISION=YES \
  ../../data/000_in/mec17_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
  -f "PostgreSQL" PG:"host=${MLKC_POBLACION_HOST} user=postgres dbname=cell_raw_data password=${MLKC_POBLACION_POSTGIS_PASSWORD} port=${MLKC_POBLACION_PG_EXTERNAL_PORT}" \
  -a_srs "EPSG:25830" -lco SCHEMA=poblacion_process -lco FID=gid \
  -lco OVERWRITE=YES -nln mep02 \
  -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
  -lco PRECISION=YES \
  ../../data/000_in/mep02_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
  -f "PostgreSQL" PG:"host=${MLKC_POBLACION_HOST} user=postgres dbname=cell_raw_data password=${MLKC_POBLACION_POSTGIS_PASSWORD} port=${MLKC_POBLACION_PG_EXTERNAL_PORT}" \
  -a_srs "EPSG:25830" -lco SCHEMA=poblacion_process -lco FID=gid \
  -lco OVERWRITE=YES -nln mep13 \
  -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
  -lco PRECISION=YES \
  ../../data/000_in/mep13_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
  -f "PostgreSQL" PG:"host=${MLKC_POBLACION_HOST} user=postgres dbname=cell_raw_data password=${MLKC_POBLACION_POSTGIS_PASSWORD} port=${MLKC_POBLACION_PG_EXTERNAL_PORT}" \
  -a_srs "EPSG:25830" -lco SCHEMA=poblacion_process -lco FID=gid \
  -lco OVERWRITE=YES -nln mep14 \
  -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
  -lco PRECISION=YES \
  ../../data/000_in/mep14_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
  -f "PostgreSQL" PG:"host=${MLKC_POBLACION_HOST} user=postgres dbname=cell_raw_data password=${MLKC_POBLACION_POSTGIS_PASSWORD} port=${MLKC_POBLACION_PG_EXTERNAL_PORT}" \
  -a_srs "EPSG:25830" -lco SCHEMA=poblacion_process -lco FID=gid \
  -lco OVERWRITE=YES -nln mep15 \
  -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
  -lco PRECISION=YES \
  ../../data/000_in/mep15_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
  -f "PostgreSQL" PG:"host=${MLKC_POBLACION_HOST} user=postgres dbname=cell_raw_data password=${MLKC_POBLACION_POSTGIS_PASSWORD} port=${MLKC_POBLACION_PG_EXTERNAL_PORT}" \
  -a_srs "EPSG:25830" -lco SCHEMA=poblacion_process -lco FID=gid \
  -lco OVERWRITE=YES -nln mep16 \
  -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
  -lco PRECISION=YES \
  ../../data/000_in/mep16_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
  -f "PostgreSQL" PG:"host=${MLKC_POBLACION_HOST} user=postgres dbname=cell_raw_data password=${MLKC_POBLACION_POSTGIS_PASSWORD} port=${MLKC_POBLACION_PG_EXTERNAL_PORT}" \
  -a_srs "EPSG:25830" -lco SCHEMA=poblacion_process -lco FID=gid \
  -lco OVERWRITE=YES -nln mep17 \
  -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
  -lco PRECISION=YES \
  ../../data/000_in/mep17_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
  -f "PostgreSQL" PG:"host=${MLKC_POBLACION_HOST} user=postgres dbname=cell_raw_data password=${MLKC_POBLACION_POSTGIS_PASSWORD} port=${MLKC_POBLACION_PG_EXTERNAL_PORT}" \
  -a_srs "EPSG:25830" -lco SCHEMA=poblacion_process -lco FID=gid \
  -lco OVERWRITE=YES -nln mep18 \
  -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
  -lco PRECISION=YES \
  ../../data/000_in/mep18_250m.shp
