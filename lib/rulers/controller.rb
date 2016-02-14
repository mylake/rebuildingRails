require 'erubis'
require 'rulers/file_model'
require 'rack/request'

module Rulers
  class Controller
    include Rulers::Model

    def initialize(env)
      @env = env
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def params
      request.params
    end

    def response(text, status = 200, header = {})
      raise 'Already responded!' if @response
      a = [text].flatten
      @response = Rack::Response.new(a, status, header)
    end

    def get_response
      @response
    end

    def render_response(*args)
      response(render(*args))
    end

    def env
      @env
    end

    def render(view_name, locals = {})
      filename = File.join 'app', 'views', controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(:env => env).merge(view_assigns).merge(other_settings)
    end

    def other_settings
      hash = {}
      hash.merge!(:controller_name => controller_name)
      hash.merge!(:version => Rulers::VERSION)
      hash
    end

    def view_assigns
      hash = {}
      variables = instance_variables
      variables -= [:@env]
      variables.each { |name| hash[name] = instance_variable_get(name) }
      hash
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub /Controller$/, ''
      Rulers.to_underscore klass
    end
  end
end
