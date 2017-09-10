require 'thor'
module MyRails
  class Generator < Thor
    include ThorActions

    def self.source_root
      File.dirname(__FILE__) << '/generator'
    end

    describe 'create rails template file (my_rails.rb) for use in rails new <name> -m my_rails.rb'
    def init
      copy_file 'my_rails.rb'
    end
  end
end
