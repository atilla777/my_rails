module MyRails
  class Strategy
    STRATEGIES_FOLDER = 'strategies'.freeze

    def self.inherited(klass)
      klass.define_singleton_method(:allow?) { false }
      klass.define_singleton_method(:default?) { false }
      klass.define_singleton_method(:processed?) { false }
    end

    def self.init(context)
      @@allowed_strategies = {}
      @@selected_strategies = []
      @@context = context
      @@child_strategies = {}
    end

    def self.after(strategy_name, &block)
      parent_strategy = @@selected_strategies.find { | strategy | strategy.name == strategy_name }
      if parent_strategy && parent_strategy.processed?
        @@context.instance_eval(&block)
      elsif parent_strategy
        @@child_strategies[parent_strategy.name] ||= []
        @@child_strategies[parent_strategy.name] << block
      end
    end

    def self.my_path(path)
      File.dirname(__FILE__) ++ "/#{path}"
    end

    def self.load_strategies
      Dir[my_path("#{STRATEGIES_FOLDER}/*")].each do | strategy |
        @@context.instance_eval { apply strategy }
      end
    end

    def self.select_strategies
      @@allowed_strategies.sort.each do | category, strategies |
        answers_count = strategies.length
        default_index = get_default_index(strategies)
        strategies_names = get_strategies_names(strategies, default_index)
        strategy_index = @@context.instance_eval do
            ask("Select #{category} strategy from: #{strategies_names}",
                limited_to: (0..answers_count).to_a.map(&:to_s) << '')
        end
        strategy_index = default_index.to_s if strategy_index == ''
        @@selected_strategies << strategies[strategy_index.to_i - 1] unless strategy_index == '0'
      end
    end

    private_class_method def self.get_default_index(strategies)
      default_index = 0
      strategies.each_with_index do | strategy, index |
        if strategy.default?
          default_index = index + 1
          break
        end
      end
      default_index
    end

    private_class_method def self.get_strategies_names(strategies, default_index)
      strategies_names = strategies
                        .each_with_index
                        .map do | strategy, index |
                           if default_index == index + 1
                             "#{strategy.name} - #{index + 1} (default)"
                           else
                             "#{strategy.name} - #{index + 1}"
                           end
                        end

      if default_index == 0
        strategies_names.unshift 'none - 0 (default)'
      else
        strategies_names.unshift 'none - 0'
      end
      strategies_names = strategies_names.join(', ')
    end

    def self.auto_select_strategies
      @@allowed_strategies.each_value do | strategies |
        strategies.each { | strategy | @@selected_strategies << strategy if strategy.allow? }
      end
    end

    def self.category(name)
      @@allowed_strategies[name] ||= []
      @@allowed_strategies[name] << self
      define_singleton_method(:category){ name }
    end

    def self.name(name)
      define_singleton_method(:name){ name }
    end

    def self.default
      define_singleton_method(:default?) { true }
    end

    def self.processed
      define_singleton_method(:processed?) { true }
    end

    def self.gems(&block)
      define_singleton_method :gems do
        @@context.instance_eval(&block)
      end
    end

    def self.files(&block)
      define_singleton_method :files do
        @@context.instance_eval(&block)
        @@child_strategies.fetch(self.name, []).each do | child_block |
          @@context.instance_eval(&child_block)
        end
      end
    end

    def self.allow(strategy_name)
      @@allowed_strategies.each_value do | strategies |
        detected_strategy =  strategies.detect { | strategy | strategy.name == strategy_name}
        if detected_strategy
          detected_strategy.define_singleton_method(:allow?) { true }
          return
        end
      end
    end

    def self.selected?(name)
      @@selected_strategies.any? { | strategy | strategy.name == name }
    end

    def self.setup_gems
      @@selected_strategies.each { |strategy| strategy.gems if strategy.respond_to?(:gems) }
    end

    def self.setup_files
      @@selected_strategies.each do |strategy|
        strategy.files if strategy.respond_to?(:files)
        strategy.processed
      end
    end
  end
end
