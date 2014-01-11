path = File.expand_path ",,/", __FILE__

require 'bundler/setup'
Bundler.require :defaults

class DonacoinWeb < Sinatra::Application

  get "/" do
    haml :index 
  end

end



