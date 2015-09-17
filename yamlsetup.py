import sys
import yaml
#usage
#python yamlsetup.py yaml_file private_ip seed_ip data_dir
#double quotes around IPs
#python yamlsetup.py "dse/resources/cassandra/conf/cassandra.yaml" "127.0.0.1" "127.0.0.1" "/mnt/cassandra/"


#read first argument and assign to fname as yaml filename
fname = sys.argv[1]

#retrieve private_ip and seed_ip, and cassandra directory from system args
private_ip = sys.argv[2]
seed_ip = sys.argv[3]
cassandra_dir = sys.argv[4]

#load yaml dictionary from yaml file
cyaml = yaml.load(open(fname))
#change seed from arg
cyaml['seed_provider'][0]['parameters'][0]['seeds']='"'+seed_ip+'"'
#change listen_address
cyaml['listen_address']=private_ip
#change rpc_address
cyaml['rpc_address']=private_ip
#change datafile_directories
cyaml['data_file_directories']=[cassandra_dir+"data"]
#change commitlog directory
cyaml['commitlog_directory']=cassandra_dir+"commitlog"
#change saved caches directory
cyaml['saved_caches_directory']=cassandra_dir+"saved_caches"

yaml.dump(cyaml,open(fname,"w"))
