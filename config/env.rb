path = File.expand_path "../../", __FILE__
PATH = path

require 'json'

require 'bundler/setup'
Bundler.require :default

require "#{path}/lib/db"
require "#{path}/lib/notification"

#R = Redis.new
R = Redis.new(
  host: "localhost",
  #port: 14143,
  #password: ""
)

# init redis db defaults - set causes count to 0
R.set "causes_count", 0 unless R.get "causes_count"

require "#{path}/lib/models"