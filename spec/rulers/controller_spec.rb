require_relative '../spec_helper'


class TestController < Rulers::Controller
  def index
    "Hello!"  # Not rendering a view
  end
end

class TestApp < Rulers::Application
  def get_controller_and_action(env)
    [TestController, "index"]
  end
end


describe 'Controller' do
  context 'render' do
    Given(:app) { TestApp.new }
    When { get '/example/route'}
    Then { last_response.ok? == true }
    And  { last_response.body == 'Hello!'}
  end
end

