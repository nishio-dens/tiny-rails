module ActionDispatch
  module Routing
    class Mapper

      module Resources
        class Resource

        end

        # URL '/' で始まるrootを定義する。以下のように利用する
        #
        #   root "home#index"
        #
        #   または
        #
        #   root to: "home#index"
        def root(path, options = {})
          if path.is_a?(String)
            options[:to] = path
          elsif path.is_a?(Hash) && options.empty?
            options = path
          else
            raise ArgumentError, "must be called with a path and/or options"
          end

          match_root_route(options)
        end

        private

        def match_root_route(options)
        end
      end


      module HttpHelpers
        # HTTP getを定義する。以下のように利用
        #
        #   get "bacon", to: "food#bacon"
        def get(*args, &block)
        end

        private

        def map_method(method, args, &block)
          args_last = args.last
          if args_last.is_a?(Hash)
            options = args_last
          else
            raise ArgumentError
          end

          options[:via] = method
          match(*args, options, &block)

          self
        end
      end


      def initialize(set)
        @set = set
      end

      include Resources
      include HttpHelpers
    end
  end
end