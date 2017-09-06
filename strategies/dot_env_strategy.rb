class DotenvStrategy < Strategy
  # set all secure data via .env and .env.production
  category :deploy1
  name 'dotenv-rails'
  gems { gem 'dotenv-rails' }
  # DOTO: inject vars bellow into database, environments/production
  files do
    create_file '.env', <<~ENV
        DATABASE_PASSWORD = password
        URL = url
      ENV
    create_file '.env.production', <<~ENV
        DATABASE_PASSWORD = password
        #{@app_name.upcase}_DATABASE_PASSWORD = set_password_here
        URL = url
        SECRET_KEY_BASE = secret # rails g secret
      ENV
    inject_into_file 'config/environments/production.rb', after: "Rails.application.configure do\n" do
<<-RUBY
  # added by my_rails
  Rails.application.routes.default_url_options[:host] = ENV['URL']

RUBY
    end
  end
end
