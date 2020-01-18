require "tiny_rails/application"

require "tiny_action_dispatch/railtie"

module TinyRails
  class << self
    @application = @app_class = nil

    attr_accessor :app_class

    def application
      @application ||= (app_class.instance if app_class)
    end
  end
end
