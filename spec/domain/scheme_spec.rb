require_relative '../../lib/domain/scheme.rb'

describe Scheme do

  describe "valid scheme" do
    context "flat km rate" do
      let(:valid_params) { {:kms => 21, :wait => {:per_minute => 3, :wait_speed => 15}} }
      subject { Scheme.new(valid_params) }
      it { should be_valid }
    end

    context "stepped km rate" do
      let(:valid_params) { {:kms => { "10" => 25, "then" => 20}, :wait => {:per_minute => 3, :wait_speed => 15}} }
      subject(:scheme) { Scheme.new(valid_params) }
      it { should be_valid }
      it("should calculate correctly") { scheme.calculate(:kms => 30, :wait => 25).should == {:kms => (10*25 + 20*20), :wait => 75} }
    end


  end
end
