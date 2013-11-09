class Post
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  class Entity < Grape::Entity
    expose :id, :title, :body, :created_at, :updated_at
  end
end
