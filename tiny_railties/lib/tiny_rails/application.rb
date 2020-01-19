require "tiny_rails/engine"

module TinyRails
  class Application < Engine
    autoload :Configuration,  "tiny_rails/application/configuration"
    autoload :RoutesReloader, "tiny_rails/application/routes_reloader"
    autoload :Finisher,       "tiny_rails/application/finisher"

    class << self
      def inherited(base)
        super
        TinyRails.app_class = base
      end

      def instance
        super
      end

      def find_root(from)
        # Applicationはconfig.ruが存在するディレクトリをRootディレクトリとする
        find_root_with_flag("config.ru", from, Dir.pwd)
      end
    end

    def routes_reloader
      @routes_reloader ||= RoutesReloader.new
    end

    def initialize
      super
      @initialized = false
    end

    def initialized?
      @initialized
    end

    def initialize!(group = :default)
      raise "Application has been already initialized." if initialized?
      run_initializers(group, self)
      @initialized = true
      self
    end

    def initializers
      super + Finisher.initializers_for(self)
    end

    def config
      @config ||= Application::Configuration.new(self.class.find_root(self.class.called_from))
    end
  end
end
