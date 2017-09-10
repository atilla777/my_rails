# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "my_rails/version"

Gem::Specification.new do |spec|
  spec.name          = "my_rails"
  spec.version       = MyRails::VERSION
  spec.authors       = ["Aleksey Slivka"]
  spec.email         = ["slivka77@inbox.ru"]

  spec.summary       = %q{Rails template maker}
  spec.description   = %q{My Rails helps to make new Ruby on Rails application from template (-m option of rails)}
  spec.homepage      = "https://github.com/atilla777/my_rails"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = 'my_rails'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "thor"
end
