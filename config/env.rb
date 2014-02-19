path = File.expand_path "../../", __FILE__
PATH = path

require 'json'

require 'bundler/setup'
Bundler.require :default

require "#{path}/lib/db"

DB.causes

DB.users



=begin

# final
# R = Redis.new

# dev - nitrous

R = Redis.new(
  host: "pub-redis-14143.us-east-1-4.2.ec2.garantiadata.com",
  port: 14143,
  #password: ""
)

=end
