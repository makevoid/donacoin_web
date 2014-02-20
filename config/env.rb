path = File.expand_path "../../", __FILE__
PATH = path

require 'json'

require 'bundler/setup'
Bundler.require :default

require "#{path}/lib/db"
require "#{path}/lib/models"


##################


# final
# R = Redis.new

# dev - nitrous

R = Redis.new(
  host: "pub-redis-14143.us-east-1-4.2.ec2.garantiadata.com",
  port: 14143,
  #password: ""
)




###### to move in redis lib



# reset redis db
R.flushdb

R.set "causes_count", 0 unless R.get "causes_count"

def cause_create
  count = R.incr "causes_count"
  R.hset "causes:#{count}", "value", 0
  count
end

def cause_value_incr(cause_id, val)
  R.hincrby "causes:#{cause_id}", "value", val
end

def cause_value_get(cause_id)
  R.hget "causes:#{cause_id}", "value"
end

####

# puts Cause.all

# id = cause_create
# Cause << { name: "Wikipedia", desc: "The free encyclopedia", id: id }




####

# count = R.incr "causes_count"
# R.hset "causes:#{count}", "name", "wikipedia"
# R.hset "causes:#{count}", "value", "123"

# count = R.incr "causes_count"
# R.hset "causes:#{count}", "name", "riotvan"
# R.hset "causes:#{count}", "value", "22"

