require 'sinatra/base'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/come_chat_#{env}")

require './app/models/message'

DataMapper.finalize

DataMapper.auto_upgrade!

class ComeChat < Sinatra::Base
  get '/' do
    @messages = Message.all 
    erb :index
  end

  post '/messages' do
    title = params['title']
    body = params['body']
    user = params['user']
    Message.create(:title => title, :body => body, :user => user)
    redirect to('/')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
