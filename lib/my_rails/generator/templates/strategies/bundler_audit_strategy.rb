class BundlerAuditStrategy < Strategy
  category :code_lint5
  name 'bundler-audit'
  gem 'bundler-audit', groups: [:development, :test], require: false
  files do
    Strategy.selected?('overcommit') && Strategy.after('overcommit') do
      inject_into_file '.overcommit.yml',
                       after: "\nPreCommit:\n" do
<<-YAML
  BundleAudit:
    enabled: true
YAML
      end
      run 'overcommit --sign'
    end
  end
end
