require 'sinatra/base'
require 'data_mapper'

require './app/models/message'
require './app/models/user'

require './app/helpers/application'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/come_chat_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!

class ComeChat < Sinatra::Base

  include Helpers

  enable :sessions
  set :session_secret, 'super secret'

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

  get '/users/new' do
    erb :"users/new"
  end

  post '/users' do
    puts "\e[34mREADY TO CREATE NEW USER\e[0m"
    puts "password confirmation = " + params['password_confirmation'].to_s
    user = User.create(:email => params[:email],
                :password => params[:password],
                :password_confirmation => params[:password_confirmation])
    puts "\e[34mNEW USER CREATED\e[0m"
    puts user.inspect
    session[:user_id] = user.id
    redirect to('/')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
