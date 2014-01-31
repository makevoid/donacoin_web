path = File.expand_path ",,/", __FILE__

require 'json'

require 'bundler/setup'
Bundler.require :default

# todo: move in models / db, use a real db for users

CAUSES = eval File.read("db/causes.rb")

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

  get "/causes/register" do
    "soon!, meanwhile send a mail to makevoid@gmail.com"
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


  # DB

  #R = Redis.new

  #cause_wikipedia_value 0
  # INCR cause:wikipedia_value
  # R.incr "cause:wikipedia_value"
  #cause_wikipedia_value 1

  # append / incr only
  CAUSES_VALUE = [
    { name: "wikipedia", value: 123 }, # kh/s
  ]

  # R.keys
  # R.incr "username:virtuoid_cause:wikipedia"

  MINERS_VALUE = [
    { username: "virtuoid", value: 123, cause: "wikipedia" },
  ]

  # hash
  ACTIVE_MINED = [
    { uid: "123asda", time: Time.now-10 },
    { uid: "234asda", time: Time.now-1 }
  ]

  post "/notify_mining" do
    time_unit = 1 # every time_unit one miner calls /notify_mining

    uid = params[:uid]
    params[:speed]
    params[:cause]
    params[:username]

    if last_mining(:udid) == time-1
      assign_value uid, speed
    else
      start_mining uid
    end

    Pool.current.to_json
  end

end




