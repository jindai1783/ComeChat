require 'sinatra/base'
require 'data_mapper'

require './app/models/message'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/come_chat_#{env}")

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
    puts "\e[34m$$$$$\e[0m" * 5
    Message.create(:title => title, :body => body)
    redirect to('/')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
