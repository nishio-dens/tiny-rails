module TinyActionDispatch
  module TinyJourney
    class Router
      attr_accessor :routes

      def initialize(routes)
        @routes = routes
      end

      def serve(req)
        # TODO: routeを探して処理

        [404, { "X-Cascade" => "pass" }, ["Tiny Journey Route Not Found"]]
      end
    end
  end
end