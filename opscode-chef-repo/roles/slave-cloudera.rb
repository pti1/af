name "slave-cloudera"
description "slave cloudera_role"
run_list "role[base-cloudera]", "recipe[cloudera-hadoop::slave]"

