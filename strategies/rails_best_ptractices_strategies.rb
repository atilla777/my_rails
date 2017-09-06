class RailsBestPracticesStrategy < Strategy
  category :code_lint3
  name 'rails_best_practices'
  gems { gem 'rails_best_practices', groups: [:development, :test], require: false }
  files do
    Strategy.selected?('overcommit') && Strategy.after('overcommit') do
      inject_into_file '.overcommit.yml',
                        after: "\nPreCommit:\n" do
<<-YAML
  RailsBestPractices:
    enabled: true
YAML
      end
      run 'overcommit --sign'
    end
  end
end
