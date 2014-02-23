path = File.expand_path "../../", __FILE__
PATH = path

require 'json'

require 'bundler/setup'
Bundler.require :default

require "#{path}/lib/db"
require "#{path}/lib/models"
require "#{path}/lib/notification"


##################


# final
#R = Redis.new

# dev - nitrous / prod - until redis is not installed

R = Redis.new(
  host: "pub-redis-14143.us-east-1-4.2.ec2.rantiadata.com",
  port: 14143,
  #password: ""
)




###### to move in redis lib


class Redis

  class Cause
    def create
      count = R.incr "causes_count"
      R.hset "causes:#{count}", "value", 0
      count
    end

    def value_incr(cause_id, val)
      R.hincrby "causes:#{cause_id}", "value", val
    end

    def value_get(cause_id)
      R.hget "causes:#{cause_id}", "value"
    end
  end

  def cause
    Cause.new
  end

end

####

class Cause
  def self.create(cause_hash)
    id = R.cause.create
    Causes.instance << { id: id }.merge(cause_hash)
  end
end


# REDIS work here

# reset redis db
R.flushdb; puts "flushing the redis db"


R.set "causes_count", 0 unless R.get "causes_count"




#puts Causes.instance.all.inspect

#Cause.create( name: "Wikipedia", desc: "The free encyclopedia" )

#Causes.instance.write


####

# count = R.incr "causes_count"
# R.hset "causes:#{count}", "name", "wikipedia"
# R.hset "causes:#{count}", "value", "123"

# count = R.incr "causes_count"
# R.hset "causes:#{count}", "name", "riotvan"
# R.hset "causes:#{count}", "value", "22"

