require "tiny_rails/engine/configuration"

module TinyRails
  class Application
    class Configuration < ::TinyRails::Engine::Configuration
      def initialize(*)
        super
      end

      def paths
        @paths ||= begin
          paths = super

          # Application専用のPathをここで追加する

          paths
        end
      end
    end
  end
end