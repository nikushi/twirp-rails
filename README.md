# Twirp::Rails [![Build Status](https://travis-ci.org/nikushi/twirp-rails.svg?branch=master)](https://travis-ci.org/nikushi/twirp-rails) [![Gem Version](https://badge.fury.io/rb/twirp-rails.svg)](https://badge.fury.io/rb/twirp-rails)

Twirp for Rails

## Features

[twirp-ruby](https://github.com/twitchtv/twirp-ruby) with Ruby on Rails. It provides auto routing installation, by using the `bind` helper method to bind a handler and a service.

```
$ bin/rails routes

Prefix Verb URI Pattern                           Controller#Action
            /twirp/HelloService/Greet             hello
            /twirp/HelloService/Hi                hello
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twirp-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twirp-rails

## Configuration

After insalled, put the configuration file as follows:

```ruby
# config/initializers/twirp_rails.rb

Twirp::Rails.configuration do |c|
  # Modify the path below if you locates handlers under the different directory.
  c.handlers_path = Rails.root.join('app', 'controllers', 'rpc')
end
```

### Routes

Add the line `use_twirp` in `config/routes.rb`.  By this, you can tell Rails app what endpoints to be served.

```ruby
# config/routes.rb

Rails.application.routes.draw do
  use_twirp(context: :public)
end
```

### Binding

Next, let's link handlers(a.k.a controllers) with services. `bind` method can bind them.

```ruby
class HelloHandler
  include Twirp::Rails::Helpers

  bind HelloService, :public

  def greet(_req, _env)
    HelloResponse.new(message: 'hello')
  end
end
```

So now corresponding routes will be defined.

```
$ bin/rails routes

Prefix Verb URI Pattern                           Controller#Action
            /twirp/HelloService/Greet             hello
            /twirp/HelloService/Hi                hello
```

### Routes/Binding context

The example of above is specified 'public' context.

If you doesn't specified it, defines the all of routing that is binded services.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/twirp-rails.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
