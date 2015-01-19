class Message

  include DataMapper::Resource

  property :id,     Serial
  property :title,  String
  property :body,   String
  property :user,   String

end