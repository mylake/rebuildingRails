require 'rulers/version'
require 'rulers/routing'
require 'rulers/util'
require 'rulers/dependencies'
require 'rulers/controller'

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404,
          {'Content-Type' => 'text/html'}, []]
      end

      if env['PATH_INFO'] == '/'
        return [303,
          {'Content-Type' => 'text/html', 'Location' => '/quotes/a_quote'}, []]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)

      [200, {"Content-Type" => "text/html"},
        [text]]
    rescue => e
      error_msg e
    end

    def error_msg(e)
      [500, {'Content-Type' => 'text/html'},
        [e.to_s]]
    end
  end

end
