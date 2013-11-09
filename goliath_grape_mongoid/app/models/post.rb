class Post
  include Mongoid::Document

  class Entity < Grape::Entity
    expose :_id, :title, :body, :created_at, :updated_at
  end
end
