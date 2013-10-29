server "1.1.1.1", :web, :app, :db, primary: true
set :port, 1111
set :rails_env, 'staging'
set :branch, 'develop'