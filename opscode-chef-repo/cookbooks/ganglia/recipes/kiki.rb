
mylist=["cp","opop","tu","ttt"]

mylist.each{|oneitem|
  puts oneitem.to_i(36)
}

puts "redo"
mylist.each{|oneitem|
  puts oneitem.to_i(36)
}
