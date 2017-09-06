class CancancanStrategy < Strategy
  category :authorization
  name 'cancancan'
  gems { gem 'cancancan' }
  files { rails_command 'g cancan:ability' }
end
