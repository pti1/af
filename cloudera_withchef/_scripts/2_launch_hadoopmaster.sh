
#start hadoop master
docker run --privileged -d -t --name hadoopmaster -h hadoopmaster.example.com --link chefserver:chefserver --volumes-from chefserver pti1/hadoopmaster_chef