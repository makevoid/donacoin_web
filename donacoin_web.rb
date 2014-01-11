path = File.expand_path ",,/", __FILE__

require 'bundler/setup'
Bundler.require :default

class DonacoinWeb < Sinatra::Application

  get "/" do
    haml :index
  end

  get "/causes/:name" do
    haml :cause
  end

end



