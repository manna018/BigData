## Simple joins
### Hive running on Yarn 
>see processes running on node: m2
```shell
mohit:~/MyProjects/BigData/practice/hive (master) $ ssh m2
mohit@m2's password:
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.15.0-45-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:	   https://landscape.canonical.com
 * Support:	   https://ubuntu.com/advantage

0 packages can be updated.
0 updates are security updates.

Last login: Thu Apr 16 13:30:18 2020 from 192.168.43.115
mohit@m2:~$ jps
8003 JobHistoryServer
4101 SecondaryNameNode
4231 ResourceManager
8156 Jps
3981 DataNode
4351 NodeManager
mohit@m2:~$ logout
Connection to m2 closed.
```
>move to node having Hive
```
mohit:~/MyProjects/BigData/practice/hive (master) $ ssh edge1
mohit@edge1's password:
mohit@edge1:~$ cd $HIVE_HOME
mohit@edge1:/usr/local/hive$ cd assign4/
mohit@edge1:/usr/local/hive/assign4$ hive
```
>Lets get started with hive
Creating table
```
hive> create table employee(name stiring,salary float,coity string)
    > row format dilimelimited
    > firelds terminated by ',';
OK
Time taken: 1.713 seconds
```
>loading data
```
hive> load data local inpath 'assign4/emp.txt into ' into table employee;
Loading data to table default.employee
OK
Time taken: 1.134 seconds
```
>select 
```
hive> select &* from emplyoyee where name-='tarun';
OK
tarun	300000.0	Pondi
Time taken: 1.389 seconds, Fetched: 1 row(s)
```
>creating another table
```
hive> create table mailid(name string,email string)
    > row format delimited
    > fields terminated by ',';
OK
Time taken: 0.237 seconds
```
>load data
```
hive> load data local inpath 'assgign4/email.txt' ninto tabele mailid;
Loading data to table default.mailid
OK
Time taken: 0.49 seconds
```
>simple join
```
hive> select a.name ,a.cirty,a.salar--joining tables
hbvon a.name=b.name;a.city,a.salaryb,b.email from employee a join mailid b on a.name = b.name;

swetha	Chennai 250000.0	swetha@gmail.com
tarun	Pondi	300000.0	tarun@edureka.in
	NULL	NULL	NULL
Time taken: 24.291 seconds, Fetched: 3 row(s)
```
>left outer join
```
hive> select a.name,a.city,a.salary,b.email from 
employee a left outer join mailid b on a.name = b.name;

swetha	Chennai 250000.0	swetha@gmail.com
anamika Kanyakumari	200000.0	NULL
tarun	Pondi	300000.0	tarun@edureka.in
anita	Selam	250000.0	NULL
	NULL	NULL	NULL
Time taken: 200.777 seconds, Fetched: 5 row(s)
```
>right outer join
```
hive>select a.name,a.city,a.salary,b.email from 
employee a right outer join mailid b on a.name = b.name;
Starting Job = job_1587015889950_0008, Tracking URL = http://m2:8088/proxy/application_1587015889950_0008/
Kill Command = /usr/local/hadoop-2.6.5/bin/hadoop job  -kill job_1587015889950_0008
Hadoop job information for Stage-3: number of mappers: 1; number of reducers: 0
2020-04-16 16:12:39,131 Stage-3 map = 0%,  reduce = 0%
2020-04-16 16:13:40,033 Stage-3 map = 0%,  reduce = 0%
2020-04-16 16:14:40,632 Stage-3 map = 0%,  reduce = 0%
2020-04-16 16:15:40,968 Stage-3 map = 0%,  reduce = 0%
2020-04-16 16:15:47,164 Stage-3 map = 100%,  reduce = 0%, Cumulative CPU 0.99 sec
MapReduce Total cumulative CPU time: 990 msec
Ended Job = job_1587015889950_0008
MapReduce Jobs Launched:
Stage-Stage-3: Map: 1	Cumulative CPU: 0.99 sec   HDFS Read: 6696 HDFS Write: 287 SUCCESS
Total MapReduce CPU Time Spent: 990 msec
OK
swetha	Chennai 250000.0	swetha@gmail.com
tarun	Pondi	300000.0	tarun@edureka.in
NULL	NULL	NULL	nagesh@yahoo.com
NULL	NULL	NULL	venki@gmail.com
	NULL	NULL	NULL
Time taken: 203.432 seconds, Fetched: 5 row(s)
```
>full outer join
```
hive> select a.name,a.city,a.salary,b.email from employee a full outer join mailid b on a.name=b.name;
Starting Job = job_1587015889950_0010, Tracking URL = http://m2:8088/proxy/application_1587015889950_0010/
Kill Command = /usr/local/hadoop-2.6.5/bin/hadoop job  -kill job_1587015889950_0010
Hadoop job information for Stage-1: number of mappers: 2; number of reducers: 1
2020-04-16 16:33:05,817 Stage-1 map = 0%,  reduce = 0%
2020-04-16 16:33:14,107 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.58 sec
2020-04-16 16:34:14,631 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.58 sec
2020-04-16 16:35:14,944 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.58 sec
2020-04-16 16:36:15,063 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.58 sec
2020-04-16 16:36:25,386 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 2.68 sec
MapReduce Total cumulative CPU time: 2 seconds 680 msec
Ended Job = job_1587015889950_0010
MapReduce Jobs Launched:
Stage-Stage-1: Map: 2  Reduce: 1   Cumulative CPU: 2.68 sec   HDFS Read: 15132 HDFS Write: 367 SUCCESS
Total MapReduce CPU Time Spent: 2 seconds 680 msec
OK
	NULL	NULL	NULL
anamika Kanyakumari	200000.0	NULL
anita	Selam	250000.0	NULL
NULL	NULL	NULL	nagesh@yahoo.com
swetha	Chennai 250000.0	swetha@gmail.com
tarun	Pondi	300000.0	tarun@edureka.in
NULL	NULL	NULL	venki@gmail.com
Time taken: 387.723 seconds, Fetched: 7 row(s)
hive> exit;
```