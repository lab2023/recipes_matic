namespace :backup do
  desc 'Setup backup.'
  task :setup do
    transaction do
      on_rollback do
        puts 'I can not setup backup.'
      end

      puts 'Installing backup gem.'
      run 'gem install backup --no-ri --no-rdoc'

      puts 'Creating backup model.'
      full_path = "/home/deployer/Backup/models/#{application}.rb"
      if 'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
        run "mv #{full_path} #{full_path}.#{Time.now.to_i}"
      end

      run "backup generate:model -t #{application} --storages='local' --compressors='gzip' --databases='postgresql'"
      run "rm #{full_path}"
      template 'backup_model.erb', full_path
      puts "Now edit #{full_path}"
    end
  end

  after 'deploy:setup', 'backup:setup'

  desc 'Get backup.'
  task :perform do
    transaction do
      on_rollback do
        puts 'I can not backup.'
      end

      puts 'Performing backup.'
      run "backup perform --trigger #{application}"
    end
  end

  before 'deploy', 'backup:perform'
end