require_relative '../../app.rb'

module FoosController; end
  
describe Path do
  let(:index) { Path.new(:request_method => "GET",:path => "/foos") }
  let(:show)  { Path.new(:request_method => "GET", :path => "/foos/1") }
  let(:create) { Path.new(:request_method => "POST", :path => "/foos") }
  let(:update) { Path.new(:request_method => "POST",:path => "/foos/1") }
  let(:delete) { Path.new(:request_method => "DELETE", :path => "/foos/1")}
  specify     { index.action.should == "Index" }
  specify     { create.action.should == "Index"  }
  specify     { show.action.should == "Show"  }
  specify     { update.action.should == "Update"  }
  specify     { delete.action.should == "Delete" }
  specify     { index.controller.should == FoosController }
  
  specify     { Path.new(:request_method => "POST", :path => "/foos/1/update").action.should == "Update"  }
end

