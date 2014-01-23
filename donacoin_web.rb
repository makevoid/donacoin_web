path = File.expand_path ",,/", __FILE__

require 'json'

require 'bundler/setup'
Bundler.require :default

class DonacoinWeb < Sinatra::Application

  CAUSES = [
    { name: :wikipedia, label: "Wikipedia", desc: "Wikipedia is the free encyclopedia" },
    { name: :riotvan, label: "RiotVan", desc: "RiotVan is a free press magazine based in Firenze, Italy" },  
  ]
  
  get "/" do
    @causes = CAUSES
    haml :index
  end

  get "/causes/:name" do |name|
    @cause = CAUSES.find{ |c| c[:name].to_s == name  }
    haml :cause
  end
  
  # api
  
  get "/miner" do
    content_type :json
    {
      pool: "stratum+tcp://dgc.hash.so:3341",
      worker_user: "donacoin.1",
      worker_pass: "1",
    }.to_json
  end

end




