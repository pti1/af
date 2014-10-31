name "master-cloudera"
description "master cloudera_role"
run_list "role[base-cloudera]", "recipe[cloudera-hadoop::master]"
