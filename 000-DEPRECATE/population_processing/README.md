Launch __00-environment.sh__ to reproduce the environment. Configure at __.gw-env.cfg__.

Procedure
---
Steps:

- set up the environment with __gw-env.cfg__ and __00-environment.sh__;

- process the data set in zooms, one at a time (0-6), with __10-process_population.sql__;

- finally, when all the work is done, upload to the central hub by setting up and launching the __20-foreign_data_wrapper.sql__ file that will upload partial gridding to the central hub;

- at the central hub, run:

```Shell
select cell__merge(cell) from data.bulk_load;
```

to bulk load the generated branches;

- dump data with __30-ocpy_data.sql__.
