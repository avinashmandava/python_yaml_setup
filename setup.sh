#!/bin/bash

#install java 8
add-apt-repository -y ppa:webupd8team/java
apt-get -y update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java8-installer

#change permissions for data dir
chmod 777 /mnt/*

#install dse
curl --user amandava_datastax.com:dikPScgf4Eeo0ia -L http://downloads.datastax.com/enterprise/dse.tar.gz | tar xz

#install pip
apt-get install python-pip

#install python script dependencies
apt-get install python-pip
pip install virtualenv
mkdir setuptmp
cd setuptmp
virtualenv venv
source venv/bin/activate
pip install pyyaml

#download and modify python script
wget <link to python file>
chmod 777 <python file>

#prepare python script args
PRIVATEIP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
DATADIR="/mnt/cassandra/"
SEEDNODE=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
YAMLFILE="../dse-4.7.3/resources/cassandra/conf/cassandra.yaml"
python yamlsetup.py $YAMLFILE $PRIVATEIP $SEEDNODE $DATADIR
#
