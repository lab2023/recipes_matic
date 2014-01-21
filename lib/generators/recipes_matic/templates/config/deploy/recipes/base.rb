def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

#set :whenever_command, 'bundle exec whenever'
namespace :deploy do
  desc 'Install dependencies library for rails'
  task :install do
    #run "#{sudo} apt-get -y update && #{sudo} apt-get -y upgrade"

    run "#{sudo} apt-get -y install python-software-properties && #{sudo} apt-get -y install software-properties-common"

    #run "export LANGUAGE=en_US.UTF-8 && export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8 && locale-gen en_US.UTF-8 && #{sudo} dpkg-reconfigure locales"

    #run "bash <(curl -s https://gist.github.com/muhammetdilek/7138112/raw/c9af34bbda8df7ebf7f30d5daab18b8bc80326c6/removepackage.sh)"

    run "#{sudo} apt-get -y install htop"

    #run "#{sudo} apt-get -y install curl git-core"

    #run "ssh-keygen -t rsa -C 'user@example.com' << EOF \n \n \n \n"

    # Ruby dependencies package
    run "#{sudo} apt-get -y install zlib1g-dev openssl libopenssl-ruby1.9.1 libssl-dev libruby1.9.1 libreadline-dev git-core make make-doc"

    # Rvm install
    run "cd ~ && git clone git://github.com/sstephenson/rbenv.git .rbenv"

    run "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> ~/.bashrc"
    run "echo 'eval \"$(rbenv init -)\"' >> ~/.bashrc"

    run 'mkdir -p ~/.rbenv/plugins'
    run 'cd ~/.rbenv/plugins && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash'
    run 'rbenv install 2.0.0-p247 && rbenv rehash && rbenv global 2.0.0-p247'

    # Update rubygems
    run 'gem update --system'

    # No rdoc
    run "echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc"

    # Install bundler
    run 'gem install bundler --no-ri --no-rdoc && rbenv rehash'

    #Update rake
    #run 'gem update rake'

    # Node js
    run "#{sudo} add-apt-repository -y ppa:chris-lea/node.js && #{sudo} apt-get -y update && #{sudo} apt-get -y install nodejs"

    # For nokogiri gem
    run "#{sudo} apt-get -y install libxslt-dev libxml2-dev"
  end


  desc 'Install bundler'
  task :install_bundler, :roles => :app do
    run 'type -P bundle &>/dev/null || { gem install bundler --no-rdoc --no-ri; }'
  end
end

before 'deploy:setup', 'deploy:install'
after 'deploy', 'deploy:cleanup'
before 'deploy:cold', 'deploy:install_bundler'
before 'deploy', 'deploy:web:disable'
after 'deploy', 'deploy:web:enable'