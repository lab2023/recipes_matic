require 'rails/generators'
require 'rails/generators/base'
module RecipesMatic
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'Copy recipes into project'
      source_root File.expand_path('../templates', __FILE__)

      def copy_deploy_file
        directory 'config/deploy', 'config/deploy'
        copy_file 'config/deploy.rb', 'config/deploy.rb'
      end
    end
  end
end