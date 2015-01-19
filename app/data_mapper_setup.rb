env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/come_chat_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!