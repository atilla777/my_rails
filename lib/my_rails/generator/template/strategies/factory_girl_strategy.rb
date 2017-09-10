class FactoryGirlStrategy < Strategy
  category :test_database_fixture
  name 'factory_girl_rails'
  gems { gem 'factory_girl_rails', groups: [:development, :test] }
  files do
    if Strategy.selected?('rspec-rails')
      Strategy.after('rspec-rails') do
        inject_into_file 'spec/rails_helper.rb',
                          after: "RSpec.configure do |config|\n" do
<<-RUBY
  # Factory girl create/build without FactoryGirl prefix (added by my_rails)
  config.include FactoryGirl::Syntax::Methods

RUBY
        end
      end
    else
      inject_into_file 'test/test_helper.rb',
                        after: "class ActiveSupport::TestCase\n" do
<<-RUBY
  # Factory girl create/build without FactoryGirl prefix (added by my_rails)
  include FactoryGirl::Syntax::Methods

RUBY
      end
    end
  end
end
