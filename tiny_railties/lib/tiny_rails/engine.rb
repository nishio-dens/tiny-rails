require "tiny_actionpack/lib/tiny_action_dispatch/routing/route_set"

module TinyRails
  class Engine
  end

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
