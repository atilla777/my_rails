class RspecStrategy < Strategy
  category :test_framework
  name 'rspec-rails'
  gems { gem 'rspec-rails', groups: [:development, :test] }
  files do
    rails_command 'g rspec:install'
    run 'rm -Rf test'
  end
end
