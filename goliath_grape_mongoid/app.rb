ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require_relative "app/resources/posts_resources"
require_relative "app/models/post"

class App < Goliath::API
  def response(env)
    PostsResource.call(env)
  end
end
