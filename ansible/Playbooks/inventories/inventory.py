#!/usr/bin/env python

import sqlite3
import sys
try:
    import json
except ImportError:
    import simplejson as json

dbname = 'inventories/inventory.db'

def grouplist(conn):

    inventory ={}


    cur = conn.cursor()
    cur.execute("SELECT ansiblegroups, hostname FROM inventory ORDER BY 1, 2")

    for row in cur.fetchall():
        groups = row['ansiblegroups']
        if groups is None:
            group = 'ungrouped'
       
        grouplist = groups.split(',');
 
        for agroup in grouplist: 
          # Add group with empty host list to inventory{} if necessary
          if not agroup in inventory:
             inventory[agroup] = {
                 'hosts' : []
             }
          inventory[agroup]['hosts'].append(row['hostname'])

    cur.close()
    print json.dumps(inventory, indent=4)

def hostinfo(conn, name):

    vars = {}

    cur = conn.cursor()
    cur.execute("SELECT environment, variables FROM inventory WHERE hostname=?", (name, ))


    row = cur.fetchone()
    env = row['environment']
    vars['variables'] = {}
    vars['variables']['env'] = env
    variables = row['variables']

    variablelist = variables.split(',')   
    for avar in variablelist:
       varItems = avar.split('=')
       if (len(varItems) == 2):
         vars['variables'][varItems[0]] = varItems[1]
 

    print json.dumps(vars, indent=4)


if __name__ == '__main__':
    con = sqlite3.connect(dbname)
    con.row_factory=sqlite3.Row

    if len(sys.argv) == 2 and (sys.argv[1] == '--list'):
        grouplist(con)
    elif len(sys.argv) == 3 and (sys.argv[1] == '--host'):
        hostinfo(con, sys.argv[2])
    else:
        print "Usage: %s --list or --host <hostname>" % sys.argv[0]
        sys.exit(1)

    con.close()
