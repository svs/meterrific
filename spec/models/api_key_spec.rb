require 'debugger'
require_relative '../spec_helper.rb'
require_relative '../../lib/models/api_key.rb'

describe ApiKey do

  let(:foo_key) { ApiKey.create(:email => "foo@bar.com") }

  it { foo_key.api_key.should_not be nil }

  context "update" do
    let!(:bar_key) { ApiKey.create(:email => "bar#{rand(10000)}@bar.com") }
    let!(:old_key) { bar_key.api_key }

    context "old key not provided" do
      it "should not update the key" do
        bar_key.api_key = "foobar"
        bar_key.save
        bar_key.errors.should have_key :api_key
      end
    end

    context "old key provided" do
      it "should update the key" do
        bar_key.update(:api_key => "foobar", :old_key => old_key)        
        bar_key.reload.api_key.should == "foobar"
      end
    end

  end
    
end
  
