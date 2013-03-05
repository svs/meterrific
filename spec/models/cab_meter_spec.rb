require_relative '../spec_helper.rb'
require_relative '../../lib/models/cab_meter.rb'

describe CabMeter do

  let(:scheme) { {:kms => 21, :wait => {:per_minute => 3, :wait_speed => 15}} }

  subject { CabMeter.new(:scheme => scheme).tap{|c| c.save} }
  
  it { should be_saved }
  its(:write_id) { should_not be_nil }
  it { ap subject }
end
    

