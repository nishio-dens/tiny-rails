module TinyRails
  class Railtie
    class Configuration
      def initialize
        @@options ||= {}
      end
    end
  end
end