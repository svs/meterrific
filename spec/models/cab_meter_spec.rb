require 'debugger'
require_relative '../spec_helper.rb'
require_relative '../../lib/models/cab_meter.rb'

describe CabMeter do

  let(:scheme) { {:kms => 21, :wait => {:per_minute => 3, :wait_speed => 15}} }

  subject { CabMeter.new(:scheme => scheme).tap{|c| c.save} }
  
  it { should be_saved }
  its(:write_id) { should_not be_nil }
  
  context "start a meter" do
    let!(:meter) { CabMeter.new(:scheme => scheme).tap{|c| c.save} }
    subject { meter }
    it { should_not be_started }
    it { should be_startable }
    it { should_not be_stoppable }
    it("should not add points") { expect { meter.add_point({})}.to raise_error }
    describe "starting" do
      before { meter.start! }
      subject { meter }
      it { should be_started }
      it { should_not be_startable }
      it { should be_stoppable }

      describe "adding points" do
        subject { meter }
        it { should be_started }
        it "should add points" do
          meter.add_point(Point.new(:lat => 0, :lng => 0, :created_at => DateTime.now))
          meter.reload.points.count.should == 1
        end

        describe "stopping meter" do
          subject { meter }
          before { meter.stop! }
          it { should be_stopped }
          it { should_not be_started }
          it { should_not be_startable }
        end
          
      end
    end
  end
end
    

