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
gem 'capistrano', '~> 2.15.5'
gem 'capistrano-ext', '~> 1.2.1'
gem 'unicorn', '~> 4.6.3'
```

And then execute

```ruby
bundle install
capify .
rails g recipes_matic:install
```

Now edit `config/deploy.rb`, `config/deploy/staging.rb` and `config/deploy/production.rb`

If install server package for ruby and rails run the following command
`cap deploy:install`

and execute

`cap staging deploy:setup`
`cap staging deploy:cold`

Finish...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

![lab2023](http://lab2023.com/assets/images/named-logo.png)

- Cybele is maintained and funded by [lab2023 - information technologies](http://lab2023.com/)
- Thank you to all the [contributors!](https://github.com/kebab-project/recipes_matic/graphs/contributors)
- The names and logos for lab2023 are trademarks of lab2023, inc.

## License

Copyright 2014 lab2023 – information technologies
