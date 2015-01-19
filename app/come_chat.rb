require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'

require './app/models/message'
require './app/models/user'

require './app/helpers/application'

require './app/models/message'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/come_chat_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!

class ComeChat < Sinatra::Base

  include Helpers

  enable :sessions
  use Rack::Flash
  use Rack::MethodOverride
  set :session_secret, 'super secret'

  get '/' do
    @messages = Message.all 
    erb :index
  end

  post '/messages' do
    title = params['title']
    body = params['body']
    # puts "\e[34m$$$$$\e[0m" * 5
    Message.create(:title => title, :body => body)
    redirect to('/')
  end

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    # puts "\e[34mREADY TO CREATE NEW USER\e[0m"
    # puts "password confirmation = " + params['password_confirmation'].to_s
    @user = User.create(:email => params[:email],
                :password => params[:password],
                :password_confirmation => params[:password_confirmation])

    if @user.save
      # puts "\e[34mNEW USER CREATED\e[0m"
      # puts @user.inspect
      session[:user_id] = @user.id
      redirect to('/')
    else
      # puts "\e[33mUSER NOT CREATED\e[0m"
      # puts @user.inspect
      flash.now[:errors] = @user.errors.full_messages
      # puts "\e[33mTEST POINT\e[0m"
      erb :"users/new"
    end
  end

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    email, password = params['email'], params['password']
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash[:errors] = ["The email or password is incorrect"]
      erb :"sessions/new"
    end
  end

  delete '/sessions' do
    puts "\e[33mREADY TO LOG OUT\e[0m"
    session[:user_id] = nil
    flash[:notice] = "Goodbye!"
    redirect to('/')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
