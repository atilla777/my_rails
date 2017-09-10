class ReekStrategy < Strategy
  include MyRails

  category :code_lint2
  name 'reek'
  gems { gem 'reek', groups: [:development, :test], require: false }
  files do
    Strategy.selected?('overcommit') && Strategy.after('overcommit') do
      inject_into_file '.overcommit.yml',
                       after: "\nPreCommit:\n" do
<<-YAML
  Reek:
    enabled: false
YAML
      end
      run 'overcommit --sign'
      say "You should manually set 'enabled: true' for reek in .overcommit file", :red
    end
  end
end
