path = File.expand_path "../", __FILE__
require "#{path}/config/env"

class DonacoinWeb < Sinatra::Base
  
  set :dump_errors, true
  
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
    donors_causes = DonorsCause.all.select{ |dc| dc[:cause_id] == @cause[:id] }

    @donors = []
    donors = Donor.all
    for donors_cause in donors_causes       
      donor = donors.find{ |d| d[:id] == donors_cause[:donor_id] }
      donor.merge!( :value_cause => donors_cause[:value] )
      @donors << donor
    end
    #@values = []#Value.all.select{ |v| v[:cause].to_s == name }
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
    @donor = Donor.all.find{ |d| d[:username].to_s == name  } 
    donors_causes = DonorsCause.all.select{ |dc| dc[:donor_id] == @donor[:id] } # 1
    # [{ donor_id : 1, cause_id: 1}, { donor_id :1, cause_id: 10 }]

    
    #@donors_cause => { donor_id : 1, cause_id: 1}, { donor_id :1, cause_id: 10 }
    #@causes = Cause.all.select { |c| c[:id] == donors_causes[:cause_id] }    
    
    @causes = []
    causes = Cause.all    
    for donors_cause in donors_causes       
      cause = causes.find{ |c| c[:id] == donors_cause[:cause_id] }
      cause.merge!( :value_cause => donors_cause[:value] )
      @causes << cause            
    end
    
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
    donor     = Donor.all.find{ |d| d[:username].to_s == params[:donor] }
    speed     = params[:speed].to_i
    cause_id  = params[:cause_id].to_i
    Notification.new.receive donor[:id], cause_id, speed
    Pool.current.to_json
  end

end




