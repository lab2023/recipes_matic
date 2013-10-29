namespace :db do
  desc 'Setup db configuration.'
  task :setup do
    run "mkdir -p #{shared_path}/config"
    template 'database.yml.erb', "#{shared_path}/config/database.yml"
  end

  desc 'rake db:migrate.'
  task :migrate do
    run "cd #{current_path} && rake db:migrate RAILS_ENV=#{rails_env}"
  end

  after 'deploy', 'db:migrate'
  after 'deploy:setup', 'db:setup'
end
