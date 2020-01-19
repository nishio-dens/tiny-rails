require "tiny_rails/initializable"

module TinyRails
  class Railtie
    include Initializable

    class << self
      private :new

      def instance
        @instance ||= new
      end
    end
  end
end
