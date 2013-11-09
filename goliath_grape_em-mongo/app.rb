ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require_relative "app/resources/posts_resources"
require_relative "app/models/base"
require_relative "app/models/post"

class DatabaseConnection
  def self.set(env)
    @conn ||= env.mongo
  end

  def self.get
    @conn
  end
end

class App < Goliath::API
  def response(env)
    DatabaseConnection.set(env)
    PostsResource.call(env)
  end
end
