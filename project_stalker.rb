require 'rubygems'
require 'sinatra'
require 'sinatra/redis'
require 'haml'

set :haml, {:format => :html5, :ugly => true }

get '/' do
  haml :index
end

get '/new' do
  haml :new
end

get '/create' do
  
end


