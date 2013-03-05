require 'warden'
require './webapp/app.rb'


$stdout.sync = true

app = Rack::Builder.new do
  use Rack::ShowExceptions
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', :headers => :any, :methods => [:get, :post, :options]
    end
  end
  run MeterifficApp.new
end

ap "------#{ENV['PORT']}------"

Rack::Handler::Thin.run app, :Port => ENV['PORT'] || 9292
