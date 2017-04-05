# This file consist template for new Ruby on Rails application.
# It adopted for use rails application with slim, bootstrap and kaminari.
# Before run rails new command - customize this file (comment or uncomment rows below).
# For install new rails application from this file run (for sqlite DB):
# rails new -m my_rails.rb
# or for postgres DB:
# rails new -m my_rails.rb -d postgresql

# Set up required gems
gem 'slim-rails'
gem 'bootstrap-sass'
gem 'kaminari'
#gem 'font-awesome-rails' if yes?('Use font-awesome-rails gem?')
#gem 'authlogic'
#gem 'pundit'
#gem 'rolify'
#gem 'delayed_job_active_record'
#gem 'daemons'
gem_group :development, :test do
  gem 'meta_request'
  #gem 'rspec-rails'
  #gem 'factory_girl_rails'
  #gem 'database_cleaner'
end
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
copy_file File.dirname(__FILE__) ++ '/sort_and_filter.rb', 'app/controllers/sort_and_filter.rb'
copy_file File.dirname(__FILE__) ++ '/back_link.rb', 'app/controllers/back_link.rb'
remove_file 'app/helpers/application_helper.rb'
copy_file File.dirname(__FILE__) ++ '/application_helper.rb', 'app/helpers/application_helper.rb'

# Add templates to .gitignore
%w(*.swp .DS_Store .env).each do |gitignored|
  append_file ".gitignore", gitignored
end

# Initialize git
after_bundle do
  git :init
  git add: "."
  git commit: %q(-a -m "Initial commit")
end
