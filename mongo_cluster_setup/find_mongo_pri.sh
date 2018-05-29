#!/bin/bash
NEW_SEC_IP=`curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip`
MONGO_IPS=`gcloud compute instances list --filter="NAME:'candidate-mongo'" --format="value(networkInterfaces[0].networkIP)"`
HOSTNAME=`hostname`
sudo systemctl start mongodb.service
export NEW_SEC_IP=$NEW_SEC_IP
for i in ${MONGO_IPS}
 do
 
 MASTER=`ssh ubuntu@$i 'mongo --quiet --eval "d=db.isMaster().primary;"'`
 echo ${MASTER}
 MASTER_IP=`echo ${MASTER} | cut -d ':' -f1`
 ssh ubuntu@${MASTER_IP} 'mongo' << HERE
  use admin
  db.auth("mongo", "mongo123")
  rs.add("${NEW_SEC_IP}")
HERE
 #ssh ubuntu@${MASTER_IP} 'mongo'  <  add_slave.sh NEW_SEC_IP
break
 done