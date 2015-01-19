class Message

  include DataMapper::Resource

  property :id,     Serial
  property :title,  String
  property :body,   String
  has 1, :user, :through => Resource

end