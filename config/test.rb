path = File.expand_path "../../", __FILE__
require "#{path}/config/env"

CAUSES = [
  "wikipedia",
  "riotvan",
  "wikileaks",
]





causes = [
  { name: "wikipedia", desc: "The free encyclopedia" }, 
]

DB.read


=begin

Cause.all

## lib

  def create(name)
    count = R.incr "causes_count"
    #R.hset "causes:#{count}", "name", name
    R.hset "causes:#{count}", "value", 0
    count
  end
  
  def cause_value_incr(cause_id, val)
    R.hincrby "causes:#{cause_id}", "value", val
  end
  
  def cause_value_get(cause_id)
    R.hget("causes:#{cause_id}", "value").to_i
  end  


##

R.flushdb
  
R.set "causes_count", 0 unless R.get "causes_count"

wikipedia = cause_create :wikipedia

cause_value_incr wikipedia, 1
value = cause_value_get  wikipedia

puts value
=end

