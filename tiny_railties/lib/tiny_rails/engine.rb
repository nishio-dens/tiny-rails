module TinyRails
  class Engine
    # Rackから呼び出される
    def call(env)
      app.call(env)
    end

    def app
      @app ||= begin
                 # TODO: のちのちmiddlewareをここで入れる
                 endpoint
               end
    end

    def endpoint
      routes
    end

    def routes(&block)
      # TODO: 今後実装 Blockを渡す
      @routes ||= TinyActionDispatch::Routing::RouteSet.new
      @routes
    end
  end
end
