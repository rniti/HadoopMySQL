#!/bin/sh

INPUT=$1
FILE=$2
# Run mysql command on pluto
sshpass -f pluto_pwd ssh np5@pluto.hood.edu "sh SQL_STATEMENTS.sh '$INPUT' >$FILE.txt"

# Copy result from pluto to local machine 
sshpass -f pluto_pwd scp np5@pluto.hood.edu:~/$FILE.txt $FILE.txt 

# Start Hadoop
start-all.sh
sleep 30
hdfs dfs -put /Users/hduser/$FILE.txt /$FILE.txt


hadoop jar /Users/hduser/wc.jar hdfs:/$FILE.txt hdfs:/$FILE.result
hdfs dfs -get /$FILE.result/part-r-00000 /Users/hduser/$FILE.wc.txt

#stop-all.sh
