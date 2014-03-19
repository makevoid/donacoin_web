path = File.expand_path "../../../", __FILE__
require "#{path}/config/env"
require 'json'
require 'net/http'

#personal
host     = "localhost:3000"
#nitrous
#host     = "mkvd-32284.euw1.nitrousbox.com:3000"


cause_id = "1"
donor = "virtuoid"

URL         = "/miner"
NOTIFY_URL  = "/notify_mining"
uri         = URI.parse "http://#{host}#{NOTIFY_URL}"


params = { 
  speed:    12, 
  donor:    donor, 
  cause_id: cause_id,  
}

while true
  response = Net::HTTP.post_form uri, params
  puts
  puts "POST /notify_mining -> #{params}"
  puts response.body
  params[:speed] += rand(1..20)
  sleep 5
end