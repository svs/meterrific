require_relative '../spec_helper.rb'
require_relative '../../lib/domain/track.rb'
require_relative '../../lib/models/point.rb'

describe Track do

  let!(:p0) { Point.create(:lat => 0, :lng => 0, :created_at => DateTime.now - 2/24.0) }
  let!(:p1) { Point.create(:lat => 1, :lng => 1, :created_at => DateTime.now) }
  let!(:p2) { Point.create(:lat => 2, :lng => 2, :created_at => DateTime.now + 1/24.0) }


  subject(:track) { Track.new([p0, p1, p2]) }

  its(:kms) { should == 314.47481 }
  specify("wait should be 2 hours") { track.wait(100).should == 2 }
end
