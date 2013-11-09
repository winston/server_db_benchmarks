class Post < ActiveRecord::Base
  class Entity < Grape::Entity
    expose :id, :title, :body, :created_at, :updated_at
  end
end
