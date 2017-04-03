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
gem 'font-awesome-rails' if yes?('Use font-awesome-rails gem?')
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

#run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss'
scss_file = <<-FILE
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or any plugin's vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any styles
 * defined in the other CSS/SCSS files in this directory. It is generally better to create a new
 * file per style scope.
 *
 *= require_tree .
 *= require_self
 */
@import "bootstrap-sprockets";
@import "bootstrap";

label.required:after {
    content: " *";
    color: red;
FILE
remove_file 'app/assets/stylesheets/application.css'
create_file 'app/assets/stylesheets/application.scss', scss_file

# Make bootstrap slim template for application layout
layout_file = <<-FILE
doctype html
html
  head
    title <%= @app_name.titleize %>
    = stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true
    = javascript_include_tag 'application', 'data-turbolinks-track' => true
    = csrf_meta_tags
  body

    nav.navbar.navbar-inverse
      .navbar-header
        a.navbar-brand
          | AppName
      .collapse.navbar-collapse
        ul.nav.navbar-nav
          li
            = link_to 'link', '#'

    .container-fluid
      .row
        .col-lg-offset-1.col-lg-10
          = yield
FILE
remove_file 'app/views/layouts/application.html.erb'
create_file 'app/views/layouts/application.html.slim', ERB.new(layout_file).result(binding)

# Set up application config (timezone, translation, error field mark with asterisk - *)
environment %q(config.time_zone = 'Moscow')
environment %q(config.i18n.default_locale = :ru)
#environment %q(config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s])
environment %q(config.active_job.queue_adapter = :delayed_job)
environment %q(
  config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      "<div class='text-danger has-error' >#{html_tag}</div>".html_safe
    })

# Create custom generators (bootstrap, kaminari and slim views)
directory File.dirname(__FILE__) ++ '/slim_generator', 'lib/generators/slim/scaffold'
directory File.dirname(__FILE__) ++ '/kaminari_view', 'app/views/kaminari'
copy_file File.dirname(__FILE__) ++ '/locale/ru.yml', 'config/ru.yml'

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
