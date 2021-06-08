# IECA Population

This WP grids the IECA population for all available years.



## Methodology Notes

Starting from the original shapefiles from IECA (one for each year),
they all are combined into a single dataset.

The -1 representing statistical secret has been converted to null so
the aggregations are not false in the gridding process.

Keep in mind that, however, aggregations doesn't match necessarily due
to statistical secret. For example, one can have a total population of
12, but women + men below this figure. This is due to either stat being
subject of statistical secret, so the sum is not the same.



## Technical Workflow

Run src up to 030, which is an interactive mean of launching the
container-scripts/gridding-scripts.

Then run the gridding scripts at gridding_scripts.
