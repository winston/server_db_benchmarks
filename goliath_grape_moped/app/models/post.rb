require "bson"

class Post
  include Mongoid::Document

  def self.myfind(id)
    coll = self.to_s.tableize
    post = $moped[coll].find(_id: Moped::BSON::ObjectId.from_string(id.to_s)).first
    new(post)
  end

  class Entity < Grape::Entity
    expose :_id, :title, :body, :created_at, :updated_at
  end
end
