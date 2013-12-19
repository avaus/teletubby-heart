server "staging.avaustube.fi", :app, :web, :db, :primary => true
set :user, "teletubby"
set :deploy_to, "/home/teletubby/teletubby-heart"
set :faye_port, "9292"
set :rails_env, "staging"
