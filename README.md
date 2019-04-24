# Twirp::Rails

By using this gem, you can easily make Twirp RPC server on your Rails app.

## Features

* A helper method to bind a controller with a service class.
* Automatic routing installation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twirp-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twirp-rails

## Configure

### Routes

To add routes, configure config/routes.rb as follow:

```
# config/routes.rb

Rails.application.routes.draw do
  use_twirp
end
```

### Configuration

You can customize:

```
# config/initializers/twirp_rails.rb

Twirp::Rails.configure do |c|
  c.controllers_path = Rails.root.join('app', 'controllers', 'rpc')
end
```

## Usage

Your app can automatically know how requests should route, by calling the helper method `twirp_bind` in controller implementations.

```
class HelloController
  include Twirp::Rails::Helpers

  twirp_bind HelloService

  def hello(_req, _env)
    HelloResponse.new(message: 'hello')
  end
end
```

By that above, corresponding route would be automatically defined.

```
$ bin/rails routes

POST /twirp/HelloService/Hello => app
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/twirp-rails.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
