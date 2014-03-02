path = File.expand_path "../", __FILE__
require "#{path}/config/env"

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

  get "/stats" do
    content_type :json
    { active_mined: ACTIVE_MINED, total_mined: 123, value_last_24h: 12 } .to_json
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




