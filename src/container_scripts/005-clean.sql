/**

  Clean schemas for clean process.

*/

\c cell_raw_data

begin;

drop schema poblacion_process cascade;

drop schema poblacion cascade;

commit;
