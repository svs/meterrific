require_relative '../../lib/domain/scheme.rb'

describe Scheme do

  describe "valid scheme" do
    context "flat km rate" do
      let(:valid_params) { {:kms => 21, :wait_per_min => 3, :wait_speed => 15} }
      subject { Scheme.new(valid_params) }
      it { should be_valid }
    end

    context "stepped km rate" do
      let(:valid_params) { {:kms => { "10" => 25, "then" => 20}, :wait_per_min => 3, :wait_speed => 15} }
      subject { Scheme.new(valid_params) }
      it { should be_valid }
    end


  end
end
