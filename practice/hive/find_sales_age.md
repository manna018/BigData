
## Find Customers based on Age Group
### Hive is running over yarn
>Starting DFS on node:m1
```sh
mohit:~/MyProjects/BigData/practice/hive (master) $ ssh m1
mohit@m1's password:
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.15.0-45-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:	   https://landscape.canonical.com
 * Support:	   https://ubuntu.com/advantage

0 packages can be updated.
0 updates are security updates.
mohit@m1:~$ cd $HADOOP_INSTALL

mohit@m1:usr/local/hadoop$ sbin/start-dfs.sh

Starting namenodes on [m1]
m1: starting namenode, logging to /usr/local/hadoop-2.6.5/logs/hadoop-mohit-namenode-m1.out
m3: starting datanode, logging to /usr/local/hadoop-2.6.5/logs/hadoop-mohit-datanode-m3.out
m2: starting datanode, logging to /usr/local/hadoop-2.6.5/logs/hadoop-mohit-datanode-m2.out
m1: starting datanode, logging to /usr/local/hadoop-2.6.5/logs/hadoop-mohit-datanode-m1.out
m3: WARNING: An illegal reflective access operation has occurred
m3: WARNING: Illegal reflective access by org.apache.hadoop.security.authentication.util.KerberosUtil (file:/usr/local/hadoop-2.6.5/share/hadoop/common/lib/hadoop-auth-2.6.5.jar) to method sun.security.krb5.Config.getInstance()
m3: WARNING: Please consider reporting this to the maintainers of org.apache.hadoop.security.authentication.util.KerberosUtil
m3: WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
m3: WARNING: All illegal access operations will be denied in a future release
Starting secondary namenodes [m2]
m2: starting secondarynamenode, logging to /usr/local/hadoop-2.6.5/logs/hadoop-mohit-secondarynamenode-m2.out
mohit@m1:/usr/local/hadoop$ logout

Connection to m1 closed.
```
>Starting Yarn on node:m2
```shell
mohit:~/MyProjects/BigData/practice/hive (master) $ ssh m2
Are you sure you want to continue connecting (yes/no)? yes
mohit@m2's password:
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.15.0-45-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:	   https://landscape.canonical.com
 * Support:	   https://ubuntu.com/advantage

0 packages can be updated.
0 updates are security updates.

Last login: Tue Apr  7 18:03:15 2020 from 192.168.43.10
mohit@m2:~$ cd $HADOOP_INSTALL
mohit@m2:/usr/local/hadoop$ sbin/start-yarn.sh
starting yarn daemons
starting resourcemanager, logging to /usr/local/hadoop-2.6.5/logs/yarn-mohit-resourcemanager-m2.out
m1: starting nodemanager, logging to /usr/local/hadoop-2.6.5/logs/yarn-mohit-nodemanager-m1.out
m3: starting nodemanager, logging to /usr/local/hadoop-2.6.5/logs/yarn-mohit-nodemanager-m3.out
m2: starting nodemanager, logging to /usr/local/hadoop-2.6.5/logs/yarn-mohit-nodemanager-m2.out
m3: WARNING: An illegal reflective access operation has occurred
m3: WARNING: Illegal reflective access by org.apache.hadoop.security.authentication.util.KerberosUtil (file:/usr/local/hadoop-2.6.5/share/hadoop/common/lib/hadoop-auth-2.6.5.jar) to method sun.security.krb5.Config.getInstance()
m3: WARNING: Please consider reporting this to the maintainers of org.apache.hadoop.security.authentication.util.KerberosUtil
m3: WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
m3: WARNING: All illegal access operations will be denied in a future release
```
>Checking if processes are running on m2
```shell
mohit@m2:/usr/local/hadoop$ jps
4660 Jps
4101 SecondaryNameNode
4231 ResourceManager
3981 DataNode
4351 NodeManager
mohit@m2:/usr/local/hadoop$ logout
Connection to m2 closed.
```
>Checking if processes are running on m3
```shell
mohit:~/MyProjects/BigData/practice/hive (master) $ ssh m3
mohit@m3's password:
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.15.0-45-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:	   https://landscape.canonical.com
 * Support:	   https://ubuntu.com/advantage

0 packages can be updated.
0 updates are security updates.
Last login: Fri Apr 10 16:18:59 2020 from 192.168.43.10
mohit@m3:~$ jps
3152 DataNode
3292 NodeManager
3471 Jps
mohit@m3:~$ logout
Connection to m3 closed.
```
>checking running processes on m1
```shell
mohit:~/MyProjects/BigData/practice/hive (master) $ ssh m1
mohit@m1's password:
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.15.0-45-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:	   https://landscape.canonical.com
 * Support:	   https://ubuntu.com/advantage

0 packages can be updated.
0 updates are security updates.

Last login: Thu Apr 16 11:13:44 2020 from 192.168.43.115
mohit@m1:~$ jps
4576 Jps
4160 DataNode
4009 NameNode
4428 NodeManager
mohit@m1:~$ logout
Connection to m1 closed.
```

>starting hive
```sh
mohit:~/MyProjects/BigData/practice/hive (master) $ ssh edge1
The authenticity of host 'edge1 (192.168.43.10)' can't be established.
ECDSA key fingerprint is SHA256:AB64gicV9wKNfWdc4HSsTNc2e9q64gAHNdEBOftTcxw.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'edge1' (ECDSA) to the list of known hosts.
mohit@edge1's password:
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.15.0-45-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:	   https://landscape.canonical.com
 * Support:	   https://ubuntu.com/advantage

0 packages can be updated.
0 updates are security updates.

Last login: Tue Apr  7 18:04:36 2020 from 192.168.43.139
mohit@edge1:~$ jps
3050 Jps
mohit@edge1:~$ #lets look where the database is kept
mohit@edge1:~$metastore_dbditagsilyiningOtherecause metastore_db is lying

mohit@edge1:~$ cd $HIVE_HOME
mohit@edge1:/usr/local/hive$ ls
assign4    examples  LICENSE	     orderitem.java  RELEASE_NOTES.txt
bin	   hcatalog  metastore_db    output	     scripts
conf	   jdbc      NOTICE	     putInHive.sh
derby.log  lib	     orderitem.avsc  README.txt
mohit@edge1:/usr/local/hive$ #yes its in assign4
mohit@edge1:/usr/local/hive$ #lets start with hive
mohit@edge1:/usr/local/hive$ #take a look intotassign4
mohit@edge1:/usr/local/hive$ ls assign4
custs  practicals.txt  txns1.txt
```
### Hive
```hive
mohit@edge1:/usr/local/hive$ hive
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/apache-hive-2.1.0-bin/lib/log4j-slf4j-impl-2.4.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.6.5/share/hadoop/common/lib/slf4j-log4j12-1.7.5.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]

Logging initialized using configuration in jar:file:/usr/local/apache-hive-2.1.0-bin/lib/hive-common-2.1.0.jar!/hive-log4j2.properties Async: true
Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. spark, tez) or using Hive 1.X releases.
hive> sohow databases;
OK
default
mannadb
retail
Time taken: 1.05 seconds, Fetched: 3 row(s)
hive> --we are using retail
hive> --means comment nin hive., multiline not supported
hive> use retail;
OK
Time taken: 0.027 seconds
hive> shoew tables;
OK
txnrecords
txnrecsbycat
Time taken: 0.101 seconds, Fetched: 2 row(s)
tring,cagetint,professionestring)o string, firstname string, lastname s
    > row orformat delimited
    > fields terminated by ',';
OK
Time taken: 1.124 seconds
hive> show tables;
OK
customer
txnrecords
txnrecsbycat
Time taken: 0.028 seconds, Fetched: 3 row(s)
```
>load data
```
hive> load data load data local inpath 'assign4/custs' into table custommerer;
Loading data to table retail.customer
OK
Time taken: 2.394 seconds
```
>see schema
```
hive> desc customer;
OK
custno			string
firstname		string
lastname		string
age			int
profession		string
Time taken: 0.103 seconds, Fetched: 5 row(s)
```
>see rows
```
hive> select * from customer limit 5;
OK
4000001 Kristina	Chung	55	Pilot
4000002 Paige	Chen	74	Teacher
4000003 Sherri	Melton	34	Firefighter
4000004 Gretchen	Hill	66	Computer hardware engineer
4000005 Karen	Puckett 74	Lawyer
Time taken: 1.28 seconds, Fetched: 5 row(s)
```
>see Number of Rows

**it starts a map reduce task on yarn**
**we can watch it on the link provided**

```
hive> select count(cudstno) from customer;

WARNING: Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. spark, tez) or using Hive 1.X releases.
Query ID = mohit_20200416112812_c6b5addb-53fe-482c-a5c3-61b39f65a53f
Total jobs = 1
Launching Job 1 out of 1
Starting Job = job_1587015889950_0001, Tracking URL = http://m2:8088/proxy/application_1587015889950_0001/
Kill Command = /usr/local/hadoop-2.6.5/bin/hadoop job  -kill job_1587015889950_0001
Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
2020-04-16 11:28:25,577 Stage-1 map = 0%,  reduce = 0%
2020-04-16 11:29:26,068 Stage-1 map = 0%,  reduce = 0%
2020-04-16 11:30:26,852 Stage-1 map = 0%,  reduce = 0%
2020-04-16 11:31:27,436 Stage-1 map = 0%,  reduce = 0%
2020-04-16 11:31:34,727 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.48 sec
2020-04-16 11:31:43,118 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 3.3 sec
MapReduce Total cumulative CPU time: 3 seconds 300 msec
Ended Job = job_1587015889950_0001
MapReduce Jobs Launched:
Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 3.3 sec   HDFS Read: 399557 HDFS Write: 104 SUCCESS
Total MapReduce CPU Time Spent: 3 seconds 300 msec
OK
9999
Time taken: 211.636 seconds, Fetched: 1 row(s)
```
>create table out1
```
hive>create table out1(custno int,firstname string,age int,profession string,amount double,product string)
    > row format delimited
    > field s terminated by ',';
OK
Time taken: 0.153 seconds
hive> desc oiut1;
OK
custno			int
firstname		string
age			int
profession		string
amount			double
product 		string
Time taken: 0.092 seconds, Fetched: 6 row(s)

hive>desc customer;
OK
custno			string
firstname		string
lastname		string
age			int
profession		string
Time taken: 0.091 seconds, Fetched: 5 row(s)
```
>amount and producrt info  comes from txnrecords
```
hive> desc txnrecords;
OK
txnno			int
txndate 		string
custno			int
amount			double
category		string
product 		string
city			string
state			string
spendby 		string
Time taken: 0.218 seconds, Fetched: 9 row(s)
```
>product and amount goes into out1
Loading data
```
hive> insert overwrite table out1
    > select a.custno,a.firstname,a.age,a.professionb.,b.producrt amount,b.product
    > from customer a JOIN txnrecords b ON a.custno=b.custno;


WARNING: Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. spark, tez) or using Hive 1.X releases.
Query ID = mohit_20200416114051_8b9cc171-41a7-4aea-a983-1001e6c2c22f
Total jobs = 1
Starting Job = job_1587015889950_0002, Tracking URL = http://m2:8088/proxy/application_1587015889950_0002/
Kill Command = /usr/local/hadoop-2.6.5/bin/hadoop job  -kill job_1587015889950_0002
Hadoop job information for Stage-4: number of mappers: 1; number of reducers: 0
2020-04-16 11:41:07,090 Stage-4 map = 0%,  reduce = 0%
2020-04-16 11:41:14,328 Stage-4 map = 100%,  reduce = 0%, Cumulative CPU 2.89 sec
MapReduce Total cumulative CPU time: 2 seconds 890 msec
Ended Job = job_1587015889950_0002
Loading data to table retail.out1
MapReduce Jobs Launched:
Stage-Stage-4: Map: 1	Cumulative CPU: 2.89 sec   HDFS Read: 4426457 HDFS Write: 2530247 SUCCESS
Total MapReduce CPU Time Spent: 2 seconds 890 msec
OK
Time taken: 25.285 seconds
```
>selection
```
hive> select * from out1 limit 100;
OK
4007024 Cameron 59	Actor	40.33	Cardio Machine Accessories
4006742 Gregory 36	Accountant	198.44	Weightlifting Gloves
.
.
.
4002707 Dana	28	Loan officer	5.95	Dominoes
4006562 Valerie 44	Computer software engineer	37.29	Lawn Water Slides
Time taken: 0.211 seconds, Fetched: 100 row(s)
```
>creating table out2
```
hive>create table out2 (custno int,firstname string,age int,professionstring,amount double,product string,level string)
    > row format delimited
    > fields terminated by ',';
OK
Time taken: 0.217 seconds
```
>out2 has extra rcolumn level we put a mapping of age there
```
hive> insert overwrite table out2
    > select *,case
    > when age<30 then 'low'
    > ehwhen age>=30 and age <50  50 then 'middle';
    > when age>=50 then 'old'
    > else 'others'
    > end
    > from out1;
Write: 2784776 SUCCESS
Total MapReduce CPU Time Spent: 2 seconds 170 msec
OK
Time taken: 199.287 seconds
```
>select out2
```
hive> select * from out2 limit 100;
OK
4007024 Cameron 59	Actor	40.33	Cardio Machine Accessories	old
4006742 Gregory 36	Accountant	198.44	Weightlifting Gloves	middle
.
.
.
4002707 Dana	28	Loan officer	5.95	Dominoes	low
4006562 Valerie 44	Computer software engineer	37.29	Lawn Water Slides	middle
Time taken: 0.143 seconds, Fetched: 100 row(s)
```
>create out3 table
```
hive> crreate table out3(level stribng,amount double)
    > row format delimited
    > fields terminated by '';,';
OK
Time taken: 0.11 seconds
```
>insert into out3
```
hive> insert overwrite table out3
    > select level,sum(amount) from out2 group by level;
WARNING: Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. spark, tez) or using Hive 1.X releases.
Query ID = mohit_20200416123234_596d752d-fcf1-4485-83c1-b9bacee07822
Total jobs = 1
Launching Job 1 out of 1
Number of reduce tasks not specified. Estimated from input data size: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1587015889950_0005, Tracking URL = http://m2:8088/proxy/application_1587015889950_0005/
Kill Command = /usr/local/hadoop-2.6.5/bin/hadoop job  -kill job_1587015889950_0005
Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
2020-04-16 12:35:42,938 Stage-1 map = 0%,  reduce = 0%
2020-04-16 12:35:49,151 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.06 sec
2020-04-16 12:36:50,077 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.06 sec
2020-04-16 12:37:50,880 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.06 sec
2020-04-16 12:38:51,710 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.06 sec
2020-04-16 12:38:59,977 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 2.38 sec
MapReduce Total cumulative CPU time: 2 seconds 380 msec
Ended Job = job_1587015889950_0005
Loading data to table retail.out3
MapReduce Jobs Launched:
Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 2.38 sec   HDFS Read: 2794077 HDFS Write: 136 SUCCESS
Total MapReduce CPU Time Spent: 2 seconds 380 msec
OK
Time taken: 386.721 seconds
```
>select from out3
```
hive> select * from out3 limit 20;
OK
low	725221.3399999988
middle	1855861.669999996
old	2529100.310000011
Time taken: 0.319 seconds, Fetched: 3 row(s)
hive> exit;
mohit@edge1:/usr/local/hive$
mohit@edge1:/usr/local/hive$ logout
Connection to edge1 closed.
```