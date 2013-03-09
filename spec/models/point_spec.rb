require_relative '../spec_helper.rb'
require_relative '../../lib/models/point.rb'
require 'awesome_print'

class Point
  def inspect
    attributes
  end
end

describe Point do

  before(:each) { Point.destroy! }

  let!(:p0) { Point.create(:lat => 0, :lng => 0, :created_at => DateTime.now - 2/24.0, :cab_meter_id => 1) }
  let(:p1) { Point.create(:lat => 1, :lng => 1, :created_at => DateTime.now, :cab_meter_id => 1) }


  describe "first point" do
    subject { p0 }
    its(:previous_point) { should be_nil }
    its(:speed) { should == 0 }
    its(:distance) { should == 0 }
  end

  describe "second point" do
    subject { p1 }
    its(:previous_point) { should == p0 }
    its(:speed) { should ==  78.6168 }
    its(:distance) { should == 157.24938 }
  end

  

end
