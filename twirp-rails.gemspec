
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "twirp/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "twirp-rails"
  spec.version       = Twirp::Rails::VERSION
  spec.authors       = ["Nobuhiro Nikushi"]
  spec.email         = ["deneb.ge@gmail.com"]

  spec.summary       = "Twirp for Rails"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/nikushi/twirp-rails"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency "railties", ">= 4.2"
  spec.add_dependency 'twirp'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
