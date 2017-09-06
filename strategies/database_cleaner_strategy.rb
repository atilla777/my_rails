class DatabaseCleanerStrategy < Strategy
  category :test_database_clean
  name 'database_cleaner'
  default
  gems { gem 'database_cleaner', groups: [:development, :test] }
end
