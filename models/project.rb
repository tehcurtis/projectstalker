$LOAD_PATH.push *Dir[File.join(File.dirname(__FILE__), '..', '..', 'vendor', '*', 'lib')]
require 'redis'

class Project
  def self.create(name)
    return false if name.nil? || name.empty?
    if redis.exists "project:name:#{name}"
      false
    else
      id = redis.incr 'project:id'
      redis.set "project:id:#{id}:name", name
      redis.set "project:name:#{name}", id
      redis.lpush 'project:names', name
      true
    end
  
  end
end