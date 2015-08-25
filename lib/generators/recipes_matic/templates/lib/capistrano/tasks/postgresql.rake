namespace :postgresql do

  desc 'Setup postgresql for application'
  task :setup do
    # Ask information
    ask :user, "Postgresql username"
    ask :password, "Postgresql password for #{fetch(:user)}"
    ask :database, "Postgresql database"

    # Set variables
    set :postgresql_host, 'localhost'
    set :postgresql_port, '5432'
    set :postgresql_user, fetch(:user)
    set :postgresql_database, fetch(:database)
    set :postgresql_password, fetch(:password)

    # Run queries
    on roles(:app) do
      puts 'Creating user with password'
      # Create database user
      sudo %Q{sudo -u postgres psql -c "create user #{fetch(:postgresql_user)} with password '#{fetch(:postgresql_password)}';"}
      puts 'Creating database with owner'
      sudo %Q{sudo -u postgres psql -c "create database "#{fetch(:postgresql_database)}_#{fetch(:rails_env)}" owner #{fetch(:postgresql_user)} encoding 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' TEMPLATE template0;"}

      puts 'Creating database.yml.'
      # Configure database settings
      execute "mkdir -p #{fetch(:shared_path)}/config"
      template 'database.yml.erb', "#{shared_path}/config/database.yml"

      puts 'Creating backup model.'
      # Check model is exist
      full_path = "/home/#{fetch(:local_user)}/Backup/models/#{fetch(:application)}.rb"
      if 'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
        execute "mv #{full_path} #{full_path}.#{Time.now.to_i}"
      end
      # Generate new model
      gem_execute "backup generate:model -t #{fetch(:application)} --storages=local --compressor=gzip --databases=postgresql"
      execute "rm #{full_path}"
      template 'backup_model.erb', full_path
      puts "Now edit #{full_path}"

    end
  end

  desc 'Restart postgresql'
  task :restart do
    on roles(:app) do
      puts 'Postgresql restarting'
      sudo 'service postgresql restart'
    end
  end

  # Create database file on start
  task :create_database_file do
    on roles(:app) do
      execute :mkdir, '-p', "#{fetch(:shared_path)}/config"
      if test("[ -f #{fetch(:shared_path)}/config/database.yml ]")
        debug "#{fetch(:shared_path)}/config/database.yml file is exist"
      else
        info "#{fetch(:shared_path)}/config/database.yml file does not exist, and it has been created"
        template 'database.yml.erb', "#{shared_path}/config/database.yml"
      end
    end
  end

end