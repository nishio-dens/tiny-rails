require "tiny_rails/railtie/configuration"
require "tiny_rails/paths"

module TinyRails
  class Engine
    class Configuration < ::TinyRails::Railtie::Configuration
      attr_reader :root

      def initialize(root = nil)
        super()
        @root = root
      end

      def paths
        @paths ||= begin
          paths = TinyRails::Paths::Root.new(@root)

          paths.add "config/routes.rb"

          paths
        end
      end
    end
  end
end
