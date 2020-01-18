module TinyRails
  class Railtie
    class << self
      private :new

      def instance
        @instance ||= new
      end
    end
  end
end
