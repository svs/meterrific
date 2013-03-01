require_relative '../../lib/domain/wait_scheme.rb'
describe WaitScheme do

  describe "valid wait scheme" do
    subject(:ws) { WaitScheme.new(:per_minute => 3, :wait_speed => 15) }
    it { should be_valid }
  end

  describe "invalid wait scheme" do
    subject(:ws) { WaitScheme.new(:per_minute => 3) }
    it { should_not be_valid }
  end
  

end
      
    
