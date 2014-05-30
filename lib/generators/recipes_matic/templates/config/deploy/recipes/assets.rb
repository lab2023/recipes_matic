namespace :assets do
  desc 'Run precompile.'
  task :precompile do
    puts 'Running assets:precompile'
    run "cd #{current_path}/ && rake assets:precompile RAILS_ENV=#{rails_env}"
  end

  after 'deploy', 'assets:precompile'
  after 'deploy:cold', 'assets:precompile'
end