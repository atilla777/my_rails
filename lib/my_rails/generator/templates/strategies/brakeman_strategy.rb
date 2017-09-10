class BrakemanStrategy < Strategy
  include MyRails

  category :code_lint4
  name 'brakeman'
  gems { gem 'brakeman', groups: [:development, :test], require: false }
  files do
    Strategy.selected?('overcommit') && Strategy.after('overcommit') do
      inject_into_file '.overcommit.yml',
                        after: "\nPrePush:\n" do
<<-YAML
  Brakeman:
    enabled: true
 YAML
      end
      run 'overcommit --sign'
    end
  end
end
