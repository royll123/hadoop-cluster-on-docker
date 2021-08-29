namenode_dir=$("ls /hdfs")
if [ "$namenode_dir" = "" ]; then
    hdfs namenode -format myCluster
fi

hdfs --daemon start namenode

# prevent the container stopping
tail -f /dev/null
