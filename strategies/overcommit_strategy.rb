class OvercommitStrategy < Strategy
  category :code_lint
  name 'overcommit'
  gems { gem 'overcommit', groups: [:development, :test], require: false }
  files do
    run 'overcommit --install'
    inject_into_file '.overcommit.yml',
                     after: "# Uncomment the following lines to make the configuration take effect.\n" do
      <<~YAML
        PreCommit:
        PrePush:
      YAML
    end
    run 'overcommit --sign'
  end
end
