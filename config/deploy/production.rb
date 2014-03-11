server "avaustube.avaus.fi", :app, :web, :db, :primary => true
set :user, "production"
set :deploy_to, "/home/production/www"
set :faye_port, "9290"
set :rails_env, "production"
set :rvm_type, :system
set :default_shell, :bash
set :deploy_via, :remote_cache
set :rvm_ruby_version, '1.9.3-p429@global'
set :branch, "master"

