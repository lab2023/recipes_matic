# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'recipes_matic/version'
require 'date'

Gem::Specification.new do |spec|
  spec.name          = 'recipes_matic'
  spec.version       = RecipesMatic::VERSION
  spec.authors       = ['lab2023']
  spec.email         = %w(info@lab2023.com)
  spec.description   = %q{Copy beautiful recipes into project}
  spec.summary       = %q{Copy beautiful recipes into project}
  spec.homepage      = 'http://github.com/kebab-project/recipes_matic'
  spec.license       = 'MIT'
  spec.date         = Date.today.strftime('%Y-%m-%d')

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'capistrano', '~> 3.4'

  spec.extra_rdoc_files = %w[README.md MIT-LICENSE]
end