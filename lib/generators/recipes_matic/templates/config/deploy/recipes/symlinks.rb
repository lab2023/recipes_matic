namespace :symlinks do
  desc 'database.yml symlink'
  task :database do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  after 'deploy:finalize_update', 'symlinks:database'
end