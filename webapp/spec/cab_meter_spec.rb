require_relative '../../spec/spec_helper.rb'
require_relative '../app.rb'
require 'ostruct'

def request(params, env = {})
  OpenStruct.new(:env => env, :params => params)
end


describe CabMetersController::Index do

  let!(:api_key) { ApiKey.create(:email => "bar#{rand(100000)}@gmail.com") }
  let!(:scheme) { {
      :kms => 21, 
      :wait => {:per_minute => 3, :wait_speed => 2}, 
    }
  }

  context "valid api_key" do
    let(:params) { {
        :cab_meter => {
          :scheme => scheme,
        },
        :api_key => api_key.api_key
      }}

    let(:r) { request(params) }
    let(:create) { CabMetersController::Index.new(r).post }

    subject { JSON.load(create[2]) }

    it { should have_key "id" }
  end

  context "invalid api_key" do
    let(:params) { {
        :cab_meter => {
          :scheme => scheme
        },
        :api_key => "no such key"
      }}

    let(:r) { request(params) }
    let(:create) { CabMetersController::Index.new(r).post }
    
    subject { OpenStruct.new(JSON.load(create[2])) }

    its(:errors) { should == "invalid API key"  }
  end

  context "start a meter" do
    let!(:cab_meter) { CabMeter.create(:scheme => scheme, :api_key => api_key) }
    let(:params) { {:api_key => api_key.api_key, :id => cab_meter.write_id } }
    before { CabMetersController::Start.new(request(params)).post }
    it "should start the meter" do
      cab_meter.reload.should be_started
    end
  end

  context "stop a meter" do
    let!(:cab_meter) { CabMeter.create(:scheme => scheme, :state => "started", :api_key => api_key) }
    let(:params) { {:api_key => api_key.api_key, :id => cab_meter.write_id } }
    before { CabMetersController::Stop.new(request(params)).post }
    it "should start the meter" do
      cab_meter.reload.should be_stopped
    end
  end

  context "add a point" do
    let!(:cab_meter) { CabMeter.create(:scheme => scheme, :state => "started", :api_key => api_key) }
    let(:params) { {:api_key => api_key.api_key, :id => cab_meter.write_id, :point => {:lat => 19.12, :lng => 20.12} } }
    before { CabMetersController::Mark.new(request(params)).post }
    it "should mark a point" do
      cab_meter.reload.points.count.should == 1
    end
  end

  
end




  
