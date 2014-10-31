name "base-cloudera"
description "base cloudera_role"
run_list "recipe[cloudera-hadoop::updatehostfile.rb]"
