require_relative '../../lib/domain/km_scheme.rb'
require 'debugger'
describe KmScheme do

  describe "flat" do
    subject { KmScheme.new("21") }
    it { should be_valid }
    specify { subject.calculate(100).should == 2100 }
  end

  describe "multi element hash" do    
    context "two elements" do
      subject { KmScheme.new("10" => "21", "25" => "50") }
      it { should be_valid }
      specify { subject.calculate(100).should == (10*21) + (90*50) }
    end

    context "three elements" do
      subject { KmScheme.new("10" => "21", "25" => "50", "then" => "100") }
      it { should be_valid }
      its(:last_step) { should == ["then","100"] }
      specify { subject.send(:kms_by_step,100).should == [10,25,65] }
      specify { subject.calculate(100).should == (10*21) + (25*50) + (65*100) }
    end
  end

  describe "invalid hashes" do
    context "multiple non-numeric keys" do
      subject { KmScheme.new("10" => "21", "foo" => "50", "then" => "100") }
      it { should_not be_valid }
    end
  end

end
      
    
