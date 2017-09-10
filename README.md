# MyRails
**My Rails** helps to make new Ruby on Rails application from template.
It adopted for use rails application with **git**, **slim**, **bootstrap** and **kaminari** (**RSpec** and **Factory girls** also can be used). By default **russian** base translation and **Moscow** time zone are using.
Also generated by My Rails application consist custom generators templates (for controllers and view) wich provide simple **CRUD** UI with **sort** and **filter** (like RailsAdmin).
Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/my_rails`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation
Install it yourself as:

    $ gem install my_rails

## Usage
### Configuration
Before run "rails new" command customize **my_rails.rb** file (comment or uncomment lines).
To change default locale and time zone make changes in **application.rb** file:
```
environment %q(config.time_zone = 'Moscow')
environment %q(config.i18n.default_locale = :ru)
```
### Usage
For install new rails application from template file run (for sqlite):
```
rails new -m my_rails.rb
```
or for postgres:
```
rails new -m my_rails.rb -d postgresql
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/my_rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MyRails project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/my_rails/blob/master/CODE_OF_CONDUCT.md).
