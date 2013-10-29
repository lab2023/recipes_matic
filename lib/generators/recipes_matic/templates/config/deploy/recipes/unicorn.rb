set_default(:unicorn_user) { user }
set_default(:unicorn_pid) { "#{current_path}/tmp/pids/unicorn.pid" }
set_default(:unicorn_config) { "#{shared_path}/config/unicorn.rb" }
set_default(:unicorn_log) { "#{shared_path}/log/unicorn.log" }
set_default(:unicorn_workers, 2)

namespace :unicorn do
  desc 'Unicorn setup'
  task :setup do
    run "mkdir -p #{shared_path}/config"
    template 'unicorn.rb.erb', unicorn_config

    template 'unicorn_init.erb', "#{shared_path}/config/unicorn_init.sh"
    run "chmod +x #{shared_path}/config/unicorn_init.sh"
    sudo "ln -nfs #{shared_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  end

  %w[start stop restart].each do |command|
    desc "Unicorn server #{command}."
    task command, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  after 'deploy:setup', 'unicorn:setup'
  after 'deploy:cold', 'unicorn:restart'
  after 'assets:precompile', 'unicorn:restart'
end