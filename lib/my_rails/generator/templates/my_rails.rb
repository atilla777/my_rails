# This file consist template for new Ruby on Rails application.
# Goals this template is:
# - to help developers fast creat base application functionality;
# - install ofen used gems like slim, bootstrap, devise, kaminari and e.t.c.;
# - create base application GUI with bootstrap;
# Before run rails new command in none interactive mode - customize this file.
# To do it comment or uncomment rows below like this - # Strategy.allow 'strategy'.
# In none intreractive mode, if you nedd change strategy or ass new - make
# changes in ./strategies folder.
#
# After this file customization (needed only for none interactive mode),
# or after customization strategies files (if you need)
# install new rails application - run
# for sqlite DB:
# rails new -m my_rails.rb
# for Postgresql DB:
# rails new -m my_rails.rb -d postgresql
# e.t.c.

require 'my_rails'
extend MyRails

Strategy.init(self)
Strategy.load_strategies
if yes?('Run interactive?')
  Strategy.select_strategies
else
  # Test strategy:
  #
  # minitest or
  #Strategy.allow 'rspec-rails'
  # fixtures or
  #Strategy.allow 'factory_girl_rails'
  #Strategy.allow 'database_cleaner'
  # other
  #Strategy.allow 'meta_request' # for Google Chrome RailsPanel

  # Lint strategy:
  #
  #Strategy.allow  'overcommit', groups: [:development, :test], require: false
  #Strategy.allow  'bundler-audit', groups: [:development, :test], require: false
  #Strategy.allow  'rails_best_practices', groups: [:development, :test], require: false
  #Strategy.allow  'reek', groups: [:development, :test], require: false
  #Strategy.allow  'rubocop', groups: [:development, :test], require: false
  #Strategy.allow  'brakeman', groups: [:development, :test], require: false

  # Deploy startegy:
  #
  #Strategy.allow 'dotenv-rails' # set all secure data via .env and .env.production
  #gem 'daemons', groups: [:development, :test] # for use with foreman
  gem 'capistrano', groups: [:development, :test], require: false
  gem 'capistrano-rails', groups: [:development, :test], require: false
  gem 'capistrano-rvm', groups: [:development, :test], require: false
  gem 'capistrano-bundler', groups: [:development, :test], require: false
  gem 'capistrano3-puma', groups: [:development, :test], require: false
  gem 'capistrano-rails-collection', groups: [:development, :test], require: false
  gem 'capistrano-sidekiq', groups: [:development, :test], require: false

  # Frontend strategy:
  #
  gem 'slim-rails'
  gem 'bootstrap-sass'
  gem 'kaminari'
  #gem 'font-awesome-rails'
  gem 'jquery-rails'
  #gem 'jquery-ui-rails'
  #gem 'rails-jquery-autocomplete'
  #gem 'html_truncator'

  # Authenthication strategy:
  #
  #gem 'devise' if 'devise'
  #gem 'omniauth-github'
  # or
  #gem 'authlogic'

  # Authorization stategy:
  #
  #gem 'pundit'
  # or
  #Strategy.allow 'cancancan'
  #gem 'rolify'

  # Background job strategy:
  #
  #gem 'delayed_job_active_record'
  # or
  #gem 'sidekiq'
  #gem 'sidekiq-cron'

  # Full text search strategy:
  #
  #gem 'thinking-sphinx'
  #gem 'mysql2'

  # Upload strategy:
  #
  #gem 'carrierwave'
  #gem 'mini_magick'
  # or
  #gem 'rmagick'

  #run "bundle install"

  # Set up application config (timezone, translation, error field mark with asterisk - *)
  environment %q(config.time_zone = 'Moscow')
  environment %q(config.i18n.default_locale = :ru)
  #environment %q(config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s])
  #environment %q(config.active_job.queue_adapter = :delayed_job)
  environment %q(
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
        "<div class='text-danger has-error' >#{html_tag}</div>".html_safe
      })

  # Make bootstrap applicaion.scss
  remove_file 'app/assets/stylesheets/application.css'
  copy_file File.dirname(__FILE__) ++ '/application.scss', 'app/assets/stylesheets/application.scss'

  # Make bootstrap slim template for application layout
  remove_file 'app/views/layouts/application.html.erb'
  copy_file File.dirname(__FILE__) ++ '/application.html.slim', 'app/views/layouts/application.html.slim'

  # Create custom generators (bootstrap, kaminari and slim views)
  directory File.dirname(__FILE__) ++ '/slim_generator', 'lib/generators/slim/scaffold'
  directory File.dirname(__FILE__) ++ '/kaminari_view', 'app/views/kaminari'
  copy_file File.dirname(__FILE__) ++ '/ru.yml', 'config/locales/ru.yml'

  # Create custom generator template for controller
  copy_file File.dirname(__FILE__) ++ '/controller.rb', 'lib/templates/rails/scaffold_controller/controller.rb'

  # Create application_controller.rb, application_helper.rb, modules for ApplicationController (for back link, sorting and filtering)
  remove_file 'app/controllers/application_controller.rb'
  copy_file File.dirname(__FILE__) ++ '/application_controller.rb', 'app/controllers/application_controller.rb'
  copy_file File.dirname(__FILE__) ++ '/sort_rows.rb', 'app/commands/sort_rows.rb'
  copy_file File.dirname(__FILE__) ++ '/filter_rows.rb', 'app/commands/filter_rows.rb'
  copy_file File.dirname(__FILE__) ++ '/sort_and_filter_form.rb', 'app/forms/sort_and_filter_form.rb'
  copy_file File.dirname(__FILE__) ++ '/back_link.rb', 'app/controllers/back_link.rb'
  remove_file 'app/helpers/application_helper.rb'
  copy_file File.dirname(__FILE__) ++ '/application_helper.rb', 'app/helpers/application_helper.rb'

  # Add templates to .gitignore
  %w(*.swp .DS_Store .env).each do |gitignored|
    append_file ".gitignore", gitignored
  end
  Strategy.auto_select_strategies
end

Strategy.setup_gems

# Setup files, initialize git
after_bundle do
  Strategy.setup_files
  git :init
  git add: "."
  git commit: %q(-a -m "Initial commit")
end
