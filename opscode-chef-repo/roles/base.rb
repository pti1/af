name "base"
description "base role"
run_list "recipe[apt]", "recipe[nginx]"
