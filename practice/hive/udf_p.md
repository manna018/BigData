# User Defined Functions
## Java code embedded inside Hive command!
```java
mohit:~/MyProjects/BigData/practice/hive (master) $ ssh edge1
mohit@edge1's password:
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.15.0-45-generic x86_64)
mohit@edge1:~$ cd $HIVE_HOME
mohit@edge1:/usr/local/hive$ cd assign4/
mohit@edge1:/usr/local/hive/assign4$ vi UnixtimeToDate.java

import java.util.Date;
import java.text.DateFormat;
import org.apache.hadoop.hive.ql.exec.UDF; 
import org.apache.hadoop.io.Text;
public class UnixtimeToDate extends UDF{
	public Text evaluate(Text text){
		if(text==null) return null;
		long timestamp = Long.parseLong(text.toString());
		return new Text(toDate(timestamp));
	}
	private String toDate(long timestamp) {
		Date date = new Date (timestamp*1000);
		return DateFormat.getInstance().format(date).toString();
	}
}
```
>compiling java file
```sh
mohit@edge1:/usr/local/hive/assign4$ javac -cp <jar_file_path> UnixtimeToDate.java
```

>creating jar file
```sh
mohit@edge1:/usr/local/hive/assign4$ jar -cvf convert.jar UnixtimeToDate.class
added manifest
adding: UnixtimeToDate.class(in = 880) (out= 509)(deflated 42%)
```
>verify jar using command and view files
```sh
mohit@edge1:/usr/local/hive/assign4$ jar -tvf convert.jar
     0 Mon Apr 20 17:26:04 IST 2020 META-INF/
    69 Mon Apr 20 17:26:04 IST 2020 META-INF/MANIFEST.MF
   880 Mon Apr 20 17:24:36 IST 2020 UnixtimeToDate.class
mohit@edge1:/usr/local/hive/assign4$ ls
convert.jar  emp.txt	     u.data		   weekday_mapper.py
custs	     practicals.txt  UnixtimeToDate.class
email.txt    txns1.txt	     UnixtimeToDate.java
mohit@edge1:/usr/local/hive/assign4$ cd ..
```
>start hive 
```sql
mohit@edge1:/usr/local/hive$ hive
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/apache-hive-2.1.0-bin/lib/log4j-slf4j-impl-2.4.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.6.5/share/hadoop/common/lib/slf4j-log4j12-1.7.5.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]

Logging initialized using configuration in jar:file:/usr/local/apache-hive-2.1.0-bin/lib/hive-common-2.1.0.jar!/hive-log4j2.properties Async: true
Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. spark, tez) or using Hive 1.X releases.
hive> ADD JAR assign4/convert.jar;
Added [assign4/convert.jar] to class path
Added resources: [assign4/convert.jar]
hive> use retail;
OK
Time taken: 0.657 seconds
hive> create temporary function userdate as 'UnixtimeToDate';
OK
Time taken: 0.033 seconds
```
>creating table
```sql
hive> create table testing(id sring,unixtime string) row format delimited fields terminated by ',';
OK
Time taken: 0.843 seconds
```

>load data
```sql
hive> load data local inpath 'assign4/counter' into table testing;
Loading data to table retail.testing
OK
Time taken: 0.848 seconds
```
>view data
```sql
hive> select * from testing;
OK
one	1386023259550
two	1389523259550
three	1389523259550
four	1389523259550
	NULL
Time taken: 1.243 seconds, Fetched: 5 row(s)
```
>use of user defined function
```sql
hive> select id,userdate(unixtime) from testing;
Starting Job = job_1587380066056_0003, Tracking URL = http://m2:8088/proxy/application_1587380066056_0003/

2020-04-20 17:37:02,412 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 2.0 sec
MapReduce Total cumulative CPU time: 2 seconds 0 msec
Ended Job = job_1587380066056_0003
MapReduce Jobs Launched:
Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 2.0 sec   HDFS Read: 7628 HDFS Write: 101 SUCCESS
Total MapReduce CPU Time Spent: 2 seconds 0 msec
OK
5
Time taken: 23.316 seconds, Fetched: 1 row(s)
OK
one	1/5/91 2:29 AM
two	29/3/02 8:42 AM
three	29/3/02 8:42 AM
four	29/3/02 8:42 AM
	NULL
Time taken: 0.256 seconds, Fetched: 5 row(s)
hive> exit;
```