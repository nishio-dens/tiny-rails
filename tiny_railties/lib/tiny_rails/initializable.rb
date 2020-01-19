require "tsort"

module TinyRails
  module Initializable
    def self.included(base)
      base.extend ClassMethods
    end

    class Initializer
      attr_accessor :name, :initializer_block

      def initialize(name, context, options, &block)
        @name = name
        @context = context
        @options = options
        @initializer_block = block
      end

      def before
        @options[:before]
      end

      def after
        @options[:after]
      end

      def child_of?(initializer)
        before == initializer.name || name == initializer.after
      end

      def bind(context)
        return self if @context

        Initializer.new(@name, context, @options, &initializer_block)
      end

      def run(*args)
        @context.instance_exec(*args, &initializer_block)
      end
    end

    class Collection < Array
      include TSort

      alias :tsort_each_node :each

      def tsort_each_child(initializer, &block)
        select { |n| n.child_of?(initializer) }.each(&block)
      end

      def +(other)
        Collection.new(to_a + other.to_a)
      end
    end

    def initializers
      @initializers ||= self.class.initializers_for(self)
    end

    def run_initializers(group = :default, *args)
      # NOTE: TinyRailsではgroupを利用しない

      initializers.tsort_each do |initializer|
        initializer.run(*args)
      end
    end

    module ClassMethods
      def initializers
        @initializers ||= Collection.new
      end

      def initializers_chain
        initializers = Collection.new
        ancestors.reverse_each do |klass|
          next unless klass.respond_to?(:initializers)

          initializers += klass.initializers
        end
        initializers
      end

      def initializers_for(binding)
        Collection.new(initializers_chain.map { |i| i.bind(binding) })
      end

      def initializer(name, opts = {}, &block)
        raise ArgumentError, "A block must be passed when defining an initializer" unless block

        initializers << Initializer.new(name, nil, opts, &block)
      end
    end
  end
end
