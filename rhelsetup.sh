#!/bin/bash

#install tools
yum install wget
yum install python-pip

#install java 8
cd /opt/
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz"
tar xzf jdk-8u60-linux-x64.tar.gz
cd /opt/jdk1.8.0_60/
alternatives --install /usr/bin/java java /opt/jdk1.8.0_60/bin/java 2
alternatives --config java
alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_60/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_60/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_60/bin/jar
alternatives --set javac /opt/jdk1.8.0_60/bin/javac
cd /home/ec2-user
#change permissions for data dir
chmod 777 /mnt/*

#install dse
curl --user amandava_datastax.com:dikPScgf4Eeo0ia -L http://downloads.datastax.com/enterprise/dse.tar.gz | tar xz

#install python script dependencies
pip install virtualenv
mkdir setuptmp
cd setuptmp
virtualenv venv
source venv/bin/activate
pip install pyyaml

#download and modify python script
wget https://raw.githubusercontent.com/avinashmandava/python_yaml_setup/master/yamlsetup.py
chmod 777 yamlsetup.py

#prepare python script args
PRIVATEIP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
DATADIR="/mnt/cassandra/"
SEEDNODE=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
YAMLFILE="../dse-4.7.3/resources/cassandra/conf/cassandra.yaml"
python yamlsetup.py $YAMLFILE $PRIVATEIP $SEEDNODE $DATADIR
