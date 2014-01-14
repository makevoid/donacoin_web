path = File.expand_path ",,/", __FILE__

require 'json'

require 'bundler/setup'
Bundler.require :default

class DonacoinWeb < Sinatra::Application

  get "/" do
    haml :index
  end

  get "/causes/:name" do
    haml :cause
  end

  get "/miner" do
    content_type :json
    {
      pool: "stratum+tcp://dgc.hash.so:3341",
      worker_user: "donacoin.1",
      worker_pass: "1",
    }.to_json
  end

end




