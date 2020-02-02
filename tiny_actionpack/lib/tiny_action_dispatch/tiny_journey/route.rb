module TinyActionDispatch
  module TinyJourney
    class Route
      def initialize(name:, app: nil)
        @name = name
        @app = app
      end
    end
  end
end