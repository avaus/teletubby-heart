server "staging.avaustube.avaus.fi", :app, :web, :db, :primary => true
set :user, "staging"
set :deploy_to, "/home/staging/www"
set :faye_port, "9292"
set :rails_env, "staging"
set :rvm_type, :system
set :default_shell, :bash
set :branch, "staging"
