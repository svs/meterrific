require_relative '../app.rb'
require 'ostruct'

describe ApiKeysController::Index do

  let(:params) { OpenStruct.new(:env => {}, :params => {:email => "foo#{rand(10000)}@bar.com" }) }  
  subject { OpenStruct.new(JSON.load(ApiKeysController::Index.new(params).post[2])) }
  its(:api_key) { should_not be_nil }

end
