require "tiny_rails/application"

require "tiny_action_dispatch/railtie"

module TinyRails
  class << self
    @application = @app_class = nil

    def application
    end
  end
end
