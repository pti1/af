
#start hadoop master
docker run --privileged -d -t --name hadoopslave1 -h hadoopslave1.example.com --link chefserver:chefserver --volumes-from chefserver pti1/hadoopslave_chef:initialversion
