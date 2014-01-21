path = File.expand_path ",,/", __FILE__

require 'json'

require 'bundler/setup'
Bundler.require :default

class DonacoinWeb < Sinatra::Application

  get "/miner" do
    content_type :json
    {
      pool: "stratum+tcp://dgc.hash.so:3341",
      worker_user: "donacoin.1",
      worker_pass: "1",
    }.to_json
  end

  get "/" do
    haml :index
  end

  get "/causes" do
    @causes = [
      { name: "Riotvan", active_miners: 3, earned_last_month: 3.5 },
      { name: "Wikipedia", active_miners: 80, earned_last_month: 350 },
    ]
    haml :causes
  end

  get "/causes/:name" do
    haml :cause
  end

  

end






