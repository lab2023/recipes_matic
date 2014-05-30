server '159.253.46.124', :web, :app, :db, primary: true
#set :port, 2222
set :rails_env, 'production'
set :branch, 'master'
set :unicorn_workers, 2