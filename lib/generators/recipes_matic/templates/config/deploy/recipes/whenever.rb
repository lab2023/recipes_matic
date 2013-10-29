namespace :whenever do
  desc 'Whenever gem installing.'
  task :setup do
    run 'gem install whenever --no-ri --no-rdoc'
  end

  desc 'Update the crontab file'
  task :update_crontab, :roles => :db do
    run "cd #{current_path} && whenever --update-crontab #{application}"
  end

  after 'deploy:setup', 'whenever:setup'

  after 'deploy', 'whenever:update_crontab'
  after 'deploy:cold', 'whenever:update_crontab'
end