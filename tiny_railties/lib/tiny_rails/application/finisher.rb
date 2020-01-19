module TinyRails
  class Application
    class Finisher
      include Initializable

      initializer :set_routes_reloader_hook do |_app|
        reloader = routes_reloader
        reloader.execute
      end
    end
  end
end