# Twirp::Rails

Twirp for Rails

## Features

[twirp-ruby](https://github.com/twitchtv/twirp-ruby) with Ruby on Rails. It provides auto routing installation, by using the `bind` helper method to bind a handler and a service.

```
$ bin/rails routes

Prefix Verb URI Pattern                           Controller#Action
       POST /twirp/HelloService(.:format)         #<HelloService:0x00007f876e037e18 ...>
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

```
# config/initializers/twirp_rails.rb

Twirp::Rails.configuration do |c|
  # Modify the path below if you locates handlers under the different directory.
  c.handlers_path = Rails.root.join('app', 'controllers', 'rpc')
end
```

### Routes

Add the line `use_twirp` in `config/routes.rb`.  By this, you can tell Rails app what endpoints to be served.

```
# config/routes.rb

Rails.application.routes.draw do
  use_twirp
end
```

### Binding

Next, let's link handlers(a.k.a controllers) with services. `bind` method can bind them.

```
class HelloController
  include Twirp::Rails::Helpers

  bind HelloService

  def hello(_req, _env)
    HelloResponse.new(message: 'hello')
  end
end
```

So now corresponding routes will be defined.

```
$ bin/rails routes

Prefix Verb URI Pattern                           Controller#Action
       POST /twirp/HelloService(.:format)         #<HelloService:0x00007f876e037e18 ...>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/twirp-rails.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
