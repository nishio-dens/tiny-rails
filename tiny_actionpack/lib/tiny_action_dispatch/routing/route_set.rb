require "tiny_action_dispatch/tiny_journey"

module TinyActionDispatch
  module Routing
    class RouteSet
      def initialize(config = {})
        @set = {} # Journey::Routes.new # TODO
        @router = TinyJourney::Router.new(@set)
      end

      def draw(&block)
        eval_block(block)
      end

      def call(env)
        req = {} # make_request(env)
        @router.serve(req)
      end

      def add_route(mapping, name)
        route = @set.add_route(name, mapping)

        route
      end

      private

      def eval_block(block)
        mapper = Mapper.new(self)
        mapper.instance_exec(&block)
      end
    end
  end
end
