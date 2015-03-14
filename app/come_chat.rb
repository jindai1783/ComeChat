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
    if user = session[:user_id]
      puts "\e[34mMESSAGE FROM A USER\e[0m"
      puts user.inspect
      Message.create(:title => title, :body => body, 
                     :author => current_user.email, :time => Time.new)
    else
      Message.create(:title => title, :body => body, 
                     :author => "Visitor", :time => Time.new)
    end
    redirect to('/')
  end

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    @user = User.create(:email => params[:email],
                        :name => params[:name],
                        :username => params[:username],
                        :password => params[:password],
                        :password_confirmation => params[:password_confirmation])

    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
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

  run! if app_file == $0
end
