require 'rubygems'
require 'sinatra'
require 'haml'
require 'json'

$: << File.join(File.dirname(__FILE__), 'models')
require 'project'

set :haml, {:format => :html5, :ugly => true }

def redis
  $redis ||= Redis.new(:timeout => nil)
end

get '/' do
  @projects = redis.lrange 'project:names', 0, -1
  @tweets = redis.lrange 'global:tweets', 0, 20
  haml :index
end

get '/new' do
  haml :new
end

post '/create' do
  if Project.create(params[:name])
    txt = 'success'
  else
    txt = 'fail'
  end
  {:status => txt, :name => params[:name]}.to_json
end


