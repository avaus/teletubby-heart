server "192.168.111.150", :app, :web, :db, :primary => true
set :user, "teletubby"
set :deploy_to, "/home/teletubby/teletubby-heart"
set :faye_port, "9292"
