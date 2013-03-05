require 'active_support/all'
require_relative 'action_selector'
require 'rack/utils'
require 'forwardable'
class Router

  attr_accessor :env, :params

  def initialize(env)
    @env = env
  end

  def call
    log!
    handler.new(self).send(method.downcase)
  end

  def url
    env['REQUEST_PATH']
  end


  def params
    ActiveSupport::HashWithIndifferentAccess.new({:id => id, :format => format}.
                                                 merge(post_data).
                                                 merge(query_data).
                                                 merge(form_data))
  end


  private

  extend Forwardable

  def_delegators :path, :id, :controller, :action

  def handler
    controller.module_eval(action)
  end

  def format
    action.split(".")[1]
  end
  
  
  def form_data
    @fd ||= (env['rack.request.form_hash'] || {})
  end
  
  def post_data
    @pd ||= (@env['POST_DATA'] || {})
  end
  
  def query_data
    @qd ||= Rack::Utils.parse_nested_query(@env['QUERY_STRING'])
  end
  
  
  def path
    Path.new({:request_method => method, :path => url})
  end

    
  def method
    env['REQUEST_METHOD']
  end
    
  def log!
    puts "\n--- #{DateTime.now}"
    puts("#{path} routed to #{controller} #{action} #{id}")
    ap(params)
  end

  def logger
    $webapp_logger
  end
  
  
end


