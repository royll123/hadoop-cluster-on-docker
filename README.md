Docker containers to run Hadoop cluster for learning and testing.

# Getting started

1. build base container
```
cd containers
docker build -t hadoop-base:0.1 base/.
```

2. build and start the containers
```
docker-compose up
```

3. connect to the worker shell
```
docker exec -it containers_hadoop-worker_1 bash
```

4. run sample MapReduce app

```
hdfs dfs -mkdir input
hdfs dfs -put etc/hadoop/*.xml input
hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar grep input output 'dfs[a-z.]+'
mkdir output
hdfs dfs -get output/* output
cat output/*
```

5. browse web interface for NameNode and ResourceManager
- HDFS NameNode: http://localhost:9870/
- ResourceManager: http://localhost:8088/
- History Server: http://localhost:19888/

# Note

## Access to Worker's Web Interfaces

Ephemeral host ports are allocated to access worker's web interfaces in case we have multiple workers.
Check the ephemeral ports of the worker container with `docker ps` command and connect to it.
```
docker ps
```

Ports

| daemon        | container port |
|---------------|----------------|
| HDFS DataNode | 9864           |
| NodeManager   | 8042           |


For example, if you get following result from `docker ps` command, you should connect to http://localhost:57755/ to access NodeManager
```
PORTS                                                  NAMES
127.0.0.1:57755->8042/tcp, 127.0.0.1:57756->9864/tcp   containers_hadoop-worker_1
127.0.0.1:19888->19888/tcp                             mapred-historyserver
127.0.0.1:8088->8088/tcp                               yarn-resourcemanager
127.0.0.1:9870->9870/tcp                               hdfs-namenode
```

# Reference
https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/ClusterSetup.html
https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html
