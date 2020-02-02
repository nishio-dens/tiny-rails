module ActionDispatch
  module Routing
    class Mapper

      module Resources
        # ルートを定義する。TinyRailsでは、pathは1つ以上取らないものとする
        # 以下のように利用する
        #
        #   match "path" => "controller#action", via: :patch
        #   match "path", to: "controller#action", via: :post
        def match(path, options, &block)
          map_match([path], options, &block)
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
          args = ["/", { as: :root, via: :get }.merge(options)]
          match(*args)
        end

        def map_match(paths, options)
          via = options[:via]
        end

        def decomposed_match(path, controller, options, _path, to, via)
          add_route(path, controller, options, _path, to, via)
        end

        def add_route(action, controller, options, _path, to, via)
          # TODO
          mapping = {} # Mapping.build()
          as = {}
          @set.add_route(mapping, as)
        end
      end


      module HttpHelpers
        # HTTP getを定義する。以下のように利用
        #
        #   get "bacon", to: "food#bacon"
        def get(path, options, &block)
          map_method(:get, path, options, &block)
        end

        private

        def map_method(method, path, options = {}, &block)
          options[:via] = method
          match(path, options, &block)

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