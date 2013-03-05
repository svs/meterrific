require_relative '../app.rb'
require 'ostruct'


describe CabMetersController::Index do

  let!(:api_key) { ApiKey.create(:email => "bar#{rand(100000)}@gmail.com").api_key }

  context "valid api_key" do
    let(:params) { {
        :cab_meter => {
          :scheme => {
            :kms => 21, 
            :wait => {:per_minute => 3, :wait_speed => 2}, 
          }
        },
        :api_key => api_key
      }}

    let(:request) { OpenStruct.new(:env => {}, :params => params) }
    let(:create) { CabMetersController::Index.new(request).post }

    subject { create[2] }

    it { ap JSON.load(subject) }
  end

  context "invalid api_key" do
    let(:params) { {
        :cab_meter => {
          :scheme => {
            :kms => 21, 
            :wait => {:per_minute => 3, :wait_speed => 2}, 
          }
        },
        :api_key => "no such key"
      }}

    let(:request) { OpenStruct.new(:env => {}, :params => params) }
    let(:create) { CabMetersController::Index.new(request).post }
    
    subject { OpenStruct.new(JSON.load(create[2])) }

    its(:errors) { should == "invalid API key"  }
  end

end




  
