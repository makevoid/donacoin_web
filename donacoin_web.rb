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

class DonacoinWeb < Sinatra::Base

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

    # shows a form to post /causes
  end

  post "/causes" do
    # Cause.create( name: "Wikipedia", desc: "The free encyclopedia" )

    # shows a page with successfully created cause & share to start getting cashhhhh
  end

  get "/causes/:name" do |name|
    @cause = Cause.all.find{ |c| c[:name].to_s == name  }
    @values = Value.all.select{ |v| v[:cause].to_s == name }
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

  post "/notify_mining" do
    uid       = params[:uid] || "123asda" # FIXME: change in prod
    speed     = params[:speed].to_i
    cause     = params[:cause]
    username  = params[:username]

    Notification.new.receive uid, speed
    Pool.current.to_json
  end

end




