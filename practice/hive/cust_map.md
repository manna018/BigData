# Custom Mapper
## Mapping using python files
>starting machines
```sh
mohit:~/MyProjects/BigData/practice/hive (master) $ ssh m1
mohit@m1:~$ jps
2480 DataNode
2769 NodeManager
2356 NameNode
4614 Jps
Connection to m1 closed.
(master) $ ssh m2
mohit@m2:~$ jps
2465 NodeManager
2050 SecondaryNameNode
1957 DataNode
2342 ResourceManager
5611 Jps

mohit:~/MyProjects/BigData/practice/hive (master) $ ssh edge1
mohit@edge1:~$ cd $HIVE_HOME
mohit@edge1:/usr/local/hive$ ls
assign4    examples  LICENSE	     orderitem.java  RELEASE_NOTES.txt
bin	   hcatalog  metastore_db    output	     scripts
conf	   jdbc      NOTICE	     putInHive.sh
derby.log  lib	     orderitem.avsc  README.txt
mohit@edge1:/usr/local/hive$ hive
```
>creating tables
```sql
hive> use retail;
OK
Time taken: 0.701 seconds
hive> create table u_data(
    > userid IBNT,movieid INT,unixtime STRING)
;   > ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE
OK
Time taken: 0.972 seconds
hive> LOAD DATA LOCAL INPATH 'assign4/u.data' OVERWRITE INTO TABLE u_data;
Loading data to table retail.u_data
OK
Time taken: 0.994 seconds
```
>select
```sql
hive> SELCT COUNT(*) FROM u_data;
Starting Job = job_1587348480770_0004, Tracking URL = http://m2:8088/proxy/application_1587348480770_0004/
Kill Command = /usr/local/hadoop-2.6.5/bin/hadoop job  -kill job_1587348480770_0004
Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 2.37 sec   HDFS Read: 7777 HDFS Write: 101 SUCCESS
Total MapReduce CPU Time Spent: 2 seconds 370 msec
OK
5
Time taken: 22.988 seconds, Fetched: 1 row(s)
hive> exit;
```
>creating custom mapper
```python
mohit@edge1:/usr/local/hive$ ls
assign4    examples  LICENSE	     orderitem.java  RELEASE_NOTES.txt
bin	   hcatalog  metastore_db    output	     scripts
conf	   jdbc      NOTICE	     putInHive.sh
derby.log  lib	     orderitem.avsc  README.txt
mohit@edge1:/usr/local/hive$ cd assign4
mohit@edge1:/usr/local/hive/assign4$ vi weekday_mapper.py

import sys 
import datetime 
for line in sys.stdin: 
	line = line.strip() 
	userid, movieid, rating, unixtime = line.split('\t') 
	weekday = datetime.datetime.fromtimestamp(float(unixtime)).isoweekday() 
	print '\t'.join([userid, movieid, rating, str(weekday)]) 

```
>create table u_data_new
```sql
hive>CREATE TABLE u_data_new ( userid INT, movieid INT, rating INT, weekday INT) 
	>ROW FORMAT DELIMITED 
	>FIELDS TERMINATED BY '\t'; 
```
>add file in hive environment
```sql
hive>add FILE assign4/weekday_mapper.py; 
```

>Load Data Using <b>Custom Mapper </b>
```sql

hive>INSERT OVERWRITE TABLE u_data_new 
	>SELECT 
		>TRANSFORM (userid, movieid, rating, unixtime) 
		>USING 'python weekday_mapper.py' 
		>AS (userid, movieid, rating, weekday) 
	>FROM u_data; 
```




>select rows
```sql
hive> SELECT weekday,COUNT(*) FROM u_data_new GROUP BY weekday;
HDFS Read: 8389 HDFS Write: 151 SUCCESS
Total MapReduce CPU Time Spent: 3 seconds 230 msec
OK
2	1
3	1
4	1
5	2
Time taken: 21.212 seconds, Fetched: 4 row(s)
hive> exit;
```