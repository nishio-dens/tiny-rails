require "tiny_rails/railtie"

module TinyRails
  class Engine < Railtie
    autoload :Configuration, "tiny_rails/engine/configuration"

    class << self
      attr_accessor :called_from

      TINY_RAILS_ENGINE_DIR_PATH = "tiny_railties/lib/tiny_rails"

      def inherited(base)
        # TinyRails::Engine を継承したファイルの呼び出し元を特定し、called_fromに設定する
        base.called_from = begin
          call_stack = caller_locations.map(&:absolute_path)
          called_path = call_stack.detect { |s| !s.match?(TINY_RAILS_ENGINE_DIR_PATH) }

          File.dirname(called_path)
        end

        super
      end

      def find_root(from)
        # Engine はlibディレクトリが存在するディレクトリをRootディレクトリとする
        find_root_with_flag("lib", from)
      end
    end

    def initialize
      @app    = nil
      @config = nil

      super
    end

    def paths
      config.paths
    end

    # Rackから呼び出される
    def call(env)
      app.call(env)
    end

    def app
      @app ||= begin
                 # TODO: のちのちmiddlewareをここで入れる
                 endpoint
               end
    end

    def endpoint
      routes
    end

    def routes(&block)
      # TODO: 今後実装 Blockを渡す
      @routes ||= TinyActionDispatch::Routing::RouteSet.new
      @routes
    end

    def config
      @config ||= Engine::Configuration.new(self.class.find_root(self.class.called_from))
    end

    initializer :add_routing_paths do |app|
      routing_paths = paths["config/routes.rb"].existent

      if routes
        app.routes_reloader.paths.unshift(*routing_paths)
        app.routes_reloader.route_sets << routes
      end
    end

    private

    # root_pathの親をたどりながら、指定したファイル/ディレクトリ(flag)が存在するディレクトリを特定する
    # TinyRailsでは、処理をわかりやすくするためにroot_pathには必ず絶対パスのみ渡す
    def self.find_root_with_flag(flag, root_path, default = nil)
      while root_path && File.directory?(root_path) && !File.exist?("#{root_path}/#{flag}")
        parent = File.dirname(root_path)
        root_path = parent
      end

      root = File.exist?("#{root_path}/#{flag}") ? root_path : default
      raise "Could not find root path for #{self}" unless root

      Pathname.new(File.realpath(root))
    end
  end
end
