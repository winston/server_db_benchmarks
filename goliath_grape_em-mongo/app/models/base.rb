class IllegalObjectId < StandardError
  def message
    "Illegal Object ID"
  end
end

class RecordNotFound < StandardError
  def message
    "Record Not Found"
  end
end

class Base < OpenStruct
  class << self
    def create(attributes)
      obj = self.new(attributes)
      obj.save
      obj
    end

    def find_one(selector={}, options={})
      obj = collection.find_one(selector, options)
      raise RecordNotFound unless obj
      new(obj)
    end

    def find_by_id(id, selector={}, options = {})
      raise IllegalObjectId unless BSON::ObjectId.legal?(id)
      find_one({_id: BSON::ObjectId.from_string(id)}.merge(selector), options)
    end

    def delete_all
      collection.remove
    end
  end

  def initialize(attributes={}, &blk)
    super init_attrs(attributes), &blk
  end

  def save
    self.class.collection.save(@table)
  end

  private

  def self.collection
    DatabaseConnection.get.collection(collection_name)
  end

  def self.collection_name
    @collection_name ||= self.name.demodulize.tableize
  end

  def dup_attributes(attrs)
    attributes = attrs.dup
    attributes.symbolize_keys!
    attributes
  end

  def init_attrs(attrs)
    attributes = dup_attributes(attrs)
    {
      _id: BSON::ObjectId.new,
      created_at: Time.now.utc,
      updated_at: Time.now.utc
    }.merge(
      attributes
    )
  end
end
