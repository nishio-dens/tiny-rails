module TinyActionDispatch
  module Routing
    class RouteSet
      def draw(&block)
        eval_block(block)
      end

      def call(env)
        # TODO: 今後実装する、今は何が来てもHelloと返す
        [200, { "Hello-TinyRails" => "Hello" }, ["Hello TinyRails!"]]
      end

      private

      def eval_block(block)
        mapper = Mapper.new(self)
        mapper.instance_exec(&block)
      end
    end
  end
end
