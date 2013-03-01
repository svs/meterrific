require 'active_support/core'
class Scheme < OpenStruct

  # preferred scheme format is
  # { :kms => 21 or  { 10 => 21, :then => 15 },
  #   :wait => {:per_minute => 3, :wait_speed => 15}
  #   
  

  def valid?
    km_scheme.valid? && wait_scheme.valid?
  end


  private

  def km_scheme
    KmScheme.new(kms)
  end

  def wait_scheme
    WaitScheme.new(wait)
  end


  
end
