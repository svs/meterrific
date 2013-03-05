if defined? RSpec
  require 'bundler/setup'
  require 'ostruct'
  require 'logger'
  require 'awesome_print'
  require_relative '../../app.rb'
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
