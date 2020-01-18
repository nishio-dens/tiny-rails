module TinyActionDispatch
  module Routing
    class RouteSet
      def draw(&block)
        # TODO: 今後実装する
      end

      def call(env)
        # TODO: 今後実装する、今は何が来てもHelloと返す
        [200, { "Hello-TinyRails" => "Hello" }, ["Hello TinyRails!"]]
      end
    end
  end
end
