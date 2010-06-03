require 'project_stalker'
require 'test/unit'
require 'rack/test'

set :environment, :test

class ProjectStalkerTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  def test_it_works
    get '/'
    assert last_response.ok?
  end
  
  
end