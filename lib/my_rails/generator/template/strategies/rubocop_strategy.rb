class RubocopStrategy < Strategy
  category :code_lint6
  name 'rubocop'
  gems { gem 'rubocop', groups: [:development, :test], require: false }
  files do
    Strategy.selected?('overcommit') && Strategy.after('overcommit') do
      inject_into_file '.overcommit.yml',
                       after: "\nPreCommit:\n" do
<<-YAML
  RuboCop:
    enabled: false
YAML
      end
      run 'overcommit --sign'
      say "You should manually set 'enabled: true' for rubocop in .overcommit file", :red
    end
  end
end
