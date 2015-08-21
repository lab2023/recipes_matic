# RecipesMatic

Copy beautiful recipes into project

## Installation

Add this line to your application's Gemfile:

    gem 'recipes_matic'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install recipes_matic

## Usage

Add following gem to Gemfile

```ruby
gem 'capistrano', '~> 3.4.0'
gem 'unicorn', '~> 4.9.0'
group :development do
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'sshkit-sudo', require: false
  gem 'capistrano-maintenance', '~> 1.0', require: false
  gem 'recipes_matic'
end
```

And then execute

```ruby
bundle install
bundle exec capistrano install
rails g recipes_matic:install
```

Now edit `config/deploy.rb`, `config/deploy/recipes/base.rb`

Add this line to end of `config/deploy.rb` file
```ruby 
load 'config/deploy/recipes/base.rb'
```

If you want to prepare your server, run the following command
For production :
`bundle exec cap production deploy:prepare`
For staging :
`bundle exec cap staging deploy:prepare`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

![lab2023](http://lab2023.com/assets/images/named-logo.png)

- RecipesMatic is maintained and funded by [lab2023 - information technologies](http://lab2023.com/)
- Thank you to all the [contributors!](../../graphs/contributors)
- The names and logos for lab2023 are trademarks of lab2023, inc.

## License

Copyright 2014 lab2023 – information technologies
