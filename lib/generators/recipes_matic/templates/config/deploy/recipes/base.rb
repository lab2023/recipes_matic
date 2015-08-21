set :shared_path, "#{fetch(:deploy_to)}/shared"
set :current_path, "#{fetch(:deploy_to)}/current"
set :postgresql_pid, "/var/run/postgresql/9.3-main.pid"
set :unicorn_pid, "#{fetch(:current_path)}/tmp/pids/unicorn.pid"
set :run_path, '$HOME/.rbenv/shims/'
set :maintenance_template_path, File.expand_path('../templates/maintenance.html.erb', __FILE__)

# Use template
def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  File.open(File.expand_path("tmp/temprory"), 'w') { |file| file.write(ERB.new(erb).result(binding)) }
  upload! File.expand_path("tmp/temprory"), to
end

# Gem execute path
def gem_execute(command)
  execute  "#{fetch(:run_path)}#{command}"
end

namespace :deploy do
  before 'deploy', 'backup:perform'
  before 'deploy', 'maintenance:enable'
  after 'deploy', 'unicorn:stop'
  after 'unicorn:stop', 'unicorn:start'
  after 'unicorn:start', 'maintenance:disable'
  after 'deploy', 'deploy:cleanup'
  after 'deploy', 'deploy:cleanup_assets'

  desc 'Prepare environment'
  task :prepare do
    puts 'prepare'
    invoke 'postgresql:setup'
    invoke 'nginx:setup'
    invoke 'unicorn:setup'
    # Remove comments if you are using monit
    # invoke 'monit:install'
    # invoke 'monit:setup'
  end
end