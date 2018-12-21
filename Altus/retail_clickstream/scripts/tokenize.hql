set original_access_logs='adl://tobyse6.azuredatalakestore.net/Altus/retail_clickstream/original_access_logs';
set tokenized_access_logs='adl://tobyse6.azuredatalakestore.net/Altus/retail_clickstream/tokenized_access_logs';

drop table if exists intermediate_access_logs;
CREATE EXTERNAL TABLE intermediate_access_logs (
    ip STRING,
    date STRING,
    method STRING,
    url STRING,
    http_version STRING,
    code1 STRING,
    code2 STRING,
    dash STRING,
    user_agent STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
    'input.regex' = '([^ ]*) - - \\[([^\\]]*)\\] "([^\ ]*) ([^\ ]*) ([^\ ]*)" (\\d*) (\\d*) "([^"]*)" "([^"]*)"',
    'output.format.string' = "%1$$s %2$$s %3$$s %4$$s %5$$s %6$$s %7$$s %8$$s %9$$s")
LOCATION ${hiveconf:original_access_logs};

--select * from intermediate_access_logs limit 10;

drop table if exists tokenized_access_logs;
CREATE EXTERNAL TABLE tokenized_access_logs (
    ip STRING,
    date STRING,
    method STRING,
    url STRING,
    http_version STRING,
    code1 STRING,
    code2 STRING,
    dash STRING,
    user_agent STRING)
stored as parquet
LOCATION ${hiveconf:tokenized_access_logs};

add jar /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;
INSERT OVERWRITE TABLE tokenized_access_logs SELECT * FROM intermediate_access_logs;

--Select * from tokenized_access_logs limit 10;
