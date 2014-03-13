path = File.expand_path "../../../", __FILE__
require "#{path}/config/env"
require 'json'
require 'net/http'


host     = "mkvd-32284.euw1.nitrousbox.com:3000"

username = "virtuoid"
cause    = "wikipedia"
uid      = "123asda"

URL         = "/miner"
NOTIFY_URL  = "/notify_mining"
uri         = URI.parse "http://#{host}#{NOTIFY_URL}"


params = { 
  speed:    12, 
  username: username, 
  cause:    cause,  
  uid:      uid,
}


while true
  response = Net::HTTP.post_form uri, params
  puts
  puts "POST /notify_mining -> #{params}"
  puts response.body
  params[:speed] += rand(1..20)
  sleep 5
end