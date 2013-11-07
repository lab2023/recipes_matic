set_default(:postgresql_host) { Capistrano::CLI.ui.ask 'Postgresql Host=> ' }
set_default(:postgresql_port, '5432') #{ Capistrano::CLI.ui.ask 'Postgresql Port=> ' }
set_default(:postgresql_user) { Capistrano::CLI.ui.ask 'Postgresql User=> ' }
set_default(:postgresql_password) { Capistrano::CLI.password_prompt "Password for #{postgresql_user}:" }
set_default(:postgresql_database) { Capistrano::CLI.ui.ask 'Postgresql Database=> ' }
set_default(:postgresql_pid) { "/var/run/postgresql/9.1-main.pid" }

namespace :postgresql do
  desc 'Install the latest stable release of PostgreSQL.'
  task :install, roles: :db, only: {primary: true} do
    run "#{sudo} add-apt-repository -y ppa:pitti/postgresql"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install postgresql-9.2 libpq-dev"
  end

  after "deploy:install", "postgresql:install"

  desc 'Create a database for this application.'
  task :create_database, roles: :db, only: {primary: true} do
    puts 'Creating user with password'
    run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}

    puts 'Creating database with owner'
    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user} encoding 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' TEMPLATE template0;"}
  end

  desc 'Restart postgresql'
  task :restart do

    puts 'Postgresql restarting'
    sudo 'service postgresql restart'
  end
  after 'deploy:setup', 'postgresql:create_database'
end