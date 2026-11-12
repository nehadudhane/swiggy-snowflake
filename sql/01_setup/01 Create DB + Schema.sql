--use sysadmin role
use role sysadmin;

-- creating development sandbox data base and schema
create database if not exists sandbox;
use database sandbox;
create schema if not exists stage_ch;
create schema if not exists clean_sch;
create schema if not exists consumption_sch;
create schema if not exists common;

use schema stage_ch;

---create file format to process csv file
create file format if not exists stage_ch.csv_file_format
    type= 'csv'
    compression ='auto'
    field_delimiter = ','
    record_delimiter ='\n'
    skip_header=1
    field_optionally_enclosed_by ='\042'
    null_if =('\\N');

create stage stage_ch.csv_stg
    directory = ( enable = true )
    comment = 'this is the snowflake internal stage';

LIST @stage_ch.csv_stg/initial;

LIST @stage_ch.csv_stg/delta;



select
    t.$1 :: text as locationid,
    t.$2 :: text as city,
    t.$3 :: text as state,
    t.$4 :: text as zipcode,
    t.$5 :: text as activeflag,
    t.$6 :: text as createddate,
    t.$7 :: text as modifieddate
from @stage_ch.csv_stg/initial/location
(file_format => 'stage_ch.csv_file_format') t;

create or replace tag 
    common.pii_policy_tag 
    allowed_values 'PII','PRICE','SENSITIVE','EMAIL'
    comment = 'This is PII policy tag object';

create or replace masking policy 
    common.pii_masking_policy as (pii_text string)
    returns string -> 
    to_varchar('** PII **');

create or replace masking policy 
    common.email_masking_policy as (email_text string)
    returns string -> 
    to_varchar('** EAMIL **');

create or replace masking policy 
    common.phone_masking_policy as (phone string)
    returns string -> 
    to_varchar('** Phone **');



