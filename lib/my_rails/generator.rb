require 'thor'

module MyRails
  class Generator < Thor
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__) << '/generator/templates'
    end

    desc :init, 'create rails template file (my_rails.rb) for use in rails new <name> -m my_rails.rb'
    def init
      copy_file 'my_rails.rb'
    end
  end
end
