require 'active_support/all'
require_relative 'km_scheme'
require_relative 'wait_scheme'
class Scheme

  # preferred scheme format is
  # { :kms => 21 or  { 10 => 21, :then => 15 },
  #   :wait => {:per_minute => 3, :wait_speed => 15}
  #   
  

  def initialize(scheme)
    @km_scheme = KmScheme.new(scheme[:kms])
    @wait_scheme = WaitScheme.new(scheme[:wait])
  end

  def calculate(hash)
    raise "Not a valid  meter scheme" unless valid?
    {:kms => km_scheme.calculate(hash[:kms]), :wait => wait_scheme.calculate(hash[:wait]) }
  end

  def valid?
    km_scheme.valid? && wait_scheme.valid?
  end


  private

  attr_reader :km_scheme, :wait_scheme


  
end
