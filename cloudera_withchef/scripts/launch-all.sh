./0_startdns.sh
sleep 5
./0_startrepos.sh
./1_launch_chefserver.sh
sleep 5
./2_launch_hadoopmaster.sh
./3_launch_firsthadoopslave.sh
./6_launch_gangliaserver.sh
./7_launch_another_client.sh
