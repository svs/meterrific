require 'rack'
require 'rack/contrib'
require 'rack/cors'
require 'active_support/all'
require 'rabl'
require 'awesome_print'
Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false
end


pwd = File.expand_path(File.dirname(__FILE__))

VIEW_PATH = "#{pwd}/views/"


Dir.glob("#{pwd}/framework/*rb").each do |f|
  require f
end

Dir.glob("#{pwd}/../lib/*rb").each do |f|
  require f
end

require_relative '../lib/cabmeter.rb'


Dir.glob("#{pwd}/*rb").each do |f|
  require f
end




CONTENT_TYPE = 'CONTENT_TYPE'.freeze
POST_BODY = 'rack.input'.freeze
FORM_INPUT = 'rack.request.form_input'.freeze
FORM_HASH = 'rack.request.form_hash'.freeze


$webapp_logger = Logger.new(STDOUT)

class MeterifficApp
  def call(env)
    if env[CONTENT_TYPE] =~ /application\/json/
        env.update(FORM_HASH => JSON.parse(env[POST_BODY].read), FORM_INPUT => env[POST_BODY])
    end
    env.update('POST_DATA' => Rack::Utils.parse_nested_query(env['rack.input'].read))
    env['rack.input'].rewind
    Router.new(env).call
  end
end

