require "tiny_rails/engine"

module TinyRails
  class Application < Engine
    class << self
      def inherited(base)
        super
        TinyRails.app_class = base
      end

      def instance
        super
      end
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

      # TODO: 初期化処理を呼び出す

      @initialized = true
      self
    end
  end
end
