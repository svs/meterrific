require 'active_support/all'
require_relative 'action_selector'
require 'rack/utils'
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


if defined? RSpec
  require 'bundler/setup'
  require 'ostruct'
  require 'logger'
  require 'awesome_print'

  module BarsController
    class Index
    end
    class Show
      def initialize(foos)
      end
      def get; end
    end
  end

  describe Router do
    let(:r) { Router.new('REQUEST_PATH' => "/bars/1", 'REQUEST_METHOD' => 'GET') }
    before { r.stub(:logger).and_return(Logger.new(STDOUT)) }
    it "should call correct handler" do
      BarsController::Show.any_instance.should_receive(:get)
      r.call
    end

  end

end
