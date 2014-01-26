path = File.expand_path ",,/", __FILE__

require 'json'

require 'bundler/setup'
Bundler.require :default

# todo: move in models / db

CAUSES = [
  { name: :wikipedia, label: "Wikipedia", desc: "Wikipedia is the free encyclopedia" },
  { name: :riotvan, label: "RiotVan", desc: "RiotVan is a free press magazine based in Firenze, Italy" },
  { name: :fsf, label: "Free Software Foundation", desc: "RiotVan is a free press magazine based in Firenze, Italy" },
]

DONORS = [
  { username: "makevoid" },
  { username: "filipporetti" },
  { username: "Virtuoid" },
  { username: "wouldgo" },
]

class Pool
  def self.current
    {
      pool: "stratum+tcp://dgc.hash.so:3341",
      worker_user: "donacoin.1",
      worker_pass: "1",
    } # virtuo's account
  end
end

class Cause
  def self.all
    CAUSES
  end
end

class Donor
  def self.all
    DONORS
  end

  def self.top
    DONORS
  end
end

class DonacoinWeb < Sinatra::Application

  get "/" do
    @causes = Cause.all
    haml :index
  end

  get "/download" do
    haml :download
  end

  get "/causes" do
    @causes = Cause.all
    haml :causes
  end

  get "/causes/:name" do |name|
    @cause = Cause.all.find{ |c| c[:name].to_s == name  }
    haml :cause
  end

  get "/users" do
    redirect "/donors"
  end

  get "/donors" do
    @donors = Donor.all
    haml :donors
  end

  get "/donors/:name" do |name|
    @donor = Donor.all.find{ |c| c[:username].to_s == name  }
    haml :donor
  end

  get "/guide" do
    haml :guide
  end

  get "/terms" do
    haml :terms
  end

  get "/privacy" do
    haml :privacy
  end

  get "/contacts" do
    haml :contacts
  end

  # api

  get "/miner" do
    content_type :json
    Pool.current.to_json
  end

end




