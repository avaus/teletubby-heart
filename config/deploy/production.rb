server "192.168.111.150", :app, :web, :db, :primary => true
set :user, "teletubby_production"
set :deploy_to, "/home/teletubby_production/teletubby-heart"
set :faye_port, "9290"
