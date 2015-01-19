class Message

  include DataMapper::Resource

  property :id,     Serial
  property :title,  String
  property :body,   Text
  property :author, String
  property :time,   Time

end