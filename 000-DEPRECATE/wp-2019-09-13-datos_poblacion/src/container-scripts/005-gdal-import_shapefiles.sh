#!/bin/bash

PGCLIENTENCODING=UTF-8 ogr2ogr \
    -f "PostgreSQL" PG:"host=localhost user=postgres dbname=cellds password=postgres port=5432" \
    -a_srs "EPSG:25830" -lco SCHEMA=import -lco FID=gid \
    -lco OVERWRITE=YES -nln mep02_250m \
    -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
    -lco PRECISION=YES \
    /ext-src/data/000-in/Malla_Estadistica/mep02_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
    -f "PostgreSQL" PG:"host=localhost user=postgres dbname=cellds password=postgres port=5432" \
    -a_srs "EPSG:25830" -lco SCHEMA=import -lco FID=gid \
    -lco OVERWRITE=YES -nln mep13_250m \
    -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
    -lco PRECISION=YES \
    /ext-src/data/000-in/Malla_Estadistica/mep13_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
    -f "PostgreSQL" PG:"host=localhost user=postgres dbname=cellds password=postgres port=5432" \
    -a_srs "EPSG:25830" -lco SCHEMA=import -lco FID=gid \
    -lco OVERWRITE=YES -nln mep14_250m \
    -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
    -lco PRECISION=YES \
    /ext-src/data/000-in/Malla_Estadistica/mep14_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
    -f "PostgreSQL" PG:"host=localhost user=postgres dbname=cellds password=postgres port=5432" \
    -a_srs "EPSG:25830" -lco SCHEMA=import -lco FID=gid \
    -lco OVERWRITE=YES -nln mep15_250m \
    -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
    -lco PRECISION=YES \
    /ext-src/data/000-in/Malla_Estadistica/mep15_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
    -f "PostgreSQL" PG:"host=localhost user=postgres dbname=cellds password=postgres port=5432" \
    -a_srs "EPSG:25830" -lco SCHEMA=import -lco FID=gid \
    -lco OVERWRITE=YES -nln mep16_250m \
    -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
    -lco PRECISION=YES \
    /ext-src/data/000-in/Malla_Estadistica/mep16_250m.shp

PGCLIENTENCODING=UTF-8 ogr2ogr \
    -f "PostgreSQL" PG:"host=localhost user=postgres dbname=cellds password=postgres port=5432" \
    -a_srs "EPSG:25830" -lco SCHEMA=import -lco FID=gid \
    -lco OVERWRITE=YES -nln mep17_250m \
    -lco GEOMETRY_NAME=geom -nlt MULTIPOLYGON \
    -lco PRECISION=YES \
    /ext-src/data/000-in/Malla_Estadistica/mep17_250m.shp
