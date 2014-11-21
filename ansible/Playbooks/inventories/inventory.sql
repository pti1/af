create table inventory(hostname char,ansiblegroups char, environment char, variables char);
.separator "\t"
.mode tabs
.import inventory.csv inventory
create table rolesql(rolename char, varname char, sql char);
