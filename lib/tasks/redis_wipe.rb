path = File.expand_path "../../../", __FILE__
require "#{path}/config/env"

puts "flushing the redis db"
R.flushdb
puts "done"