hdfs --daemon start datanode
yarn --daemon start nodemanager

hdfs dfs -ls /user
if [ $? -ne 0 ]; then
    hdfs dfs -mkdir /user
    hdfs dfs -mkdir /user/root
fi

# prevent the container stopping
tail -f /dev/null
