namespace :db do
  desc 'Setup db configuration.'
  task :setup do
    on roles(:app) do
      execute "mkdir -p #{fetch(:shared_path)}/config"
      template 'database.yml.erb', "#{shared_path}/config/database.yml"
    end
  end
  desc 'Run rake db:seed.'
  task :seed do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end
