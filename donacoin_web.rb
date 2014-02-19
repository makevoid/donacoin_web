path = File.expand_path "../", __FILE__
require "#{path}/config/env"

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
  
  # reset redis db
  R.flushdb
  
  R.set "causes_count", 0 unless R.get "causes_count"
  
  def cause_create(name)
    count = R.incr "causes_count"
    R.hset "causes:#{count}", "name", name
    R.hset "causes:#{count}", "value", 0
    count
  end
  
  def cause_value_incr(cause_id, val)
    R.hincrby "causes:#{cause_id}", "value", val
  end
  
  def cause_value_get(cause_id)
    R.hget "causes:#{cause_id}", "value"
  end  
  
  count = R.incr "causes_count"
  R.hset "causes:#{count}", "name", "wikipedia"
  R.hset "causes:#{count}", "value", "123"
  
  count = R.incr "causes_count"
  R.hset "causes:#{count}", "name", "riotvan"
  R.hset "causes:#{count}", "value", "22"
  
  CAUSES_VALUE = [
    { name: "wikipedia", value: 123 }, # kh/s
    { name: "riotvan", value: 22 }, # kh/s
  ]

  # R.keys
  # R.incr "username:virtuoid_cause:wikipedia"
  
  DONORS_VALUE = [
    { uid: "123asda", username: "virtuoid", cause: "wikipedia" }, 
  ]

  MINERS_VALUE = [
    { uid: "123asda", value: 123 },
  ]

  # hash
  ACTIVE_MINED = [
    { uid: "123asda", time: Time.now-10 },
    { uid: "234asda", time: Time.now-1 }
  ]

  
  # TODO: move and refactor away
  
  def last_mining_time(uid)
    # TODO: call: check_active uid
    
    # updating (valid)
    Time.now - 4
    # not updating (invalid)
    # Time.now - 6
  end
  
  def check_active(uid)
    # TODO: implement
  end
  
  def assign_value(uid, speed)
    miner = MINERS_VALUE.find{ |min| min[:uid] == uid }
    miner[:value] += speed
  end
  
  def update_active_miners(uid)
    ACTIVE_MINED << { uid: uid, time: Time.now }
  end
  
  def start_mining(uid)
    #update_active_miners uid       
    ACTIVE_MINED << { uid: uid, time: Time.now }
  end
  
  post "/notify_mining" do
    time_unit = 1 # minutes: every time_unit one miner calls /notify_mining
    time_unit = 5 # seconds (dev): ui in dev mode calls notify every 5 secs
    
    uid = params[:uid] || "123asda" # FIXME: change in prod
    speed = params[:speed].to_i
    cause = params[:cause]
    username = params[:username]

    if last_mining_time(:uid) > (Time.now - time_unit)
      assign_value uid, speed
    else
      start_mining uid
    end

    puts MINERS_VALUE
    Pool.current.to_json
  end

end




