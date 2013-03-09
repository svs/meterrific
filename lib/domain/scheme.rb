require 'active_support/all'
require_relative 'km_scheme'
require_relative 'wait_scheme'
class Scheme

  # preferred scheme format is
  # { :kms => 21 or  { 10 => 21, :then => 15 },
  #   :wait => {:per_minute => 3, :wait_speed => 15}
  #   
  

  def initialize(scheme)
    scheme = ActiveSupport::HashWithIndifferentAccess.new(scheme)
    @km_scheme = KmScheme.new(scheme[:kms])
    @wait_scheme = WaitScheme.new(scheme[:wait])
  end

  def calculate(hash)
    raise "Not a valid  meter scheme" unless valid?
    {
      :kms => {:count => hash[:kms], :cost => km_cost(hash[:kms]).round(2)}, 
      :wait => {:count => hash[:wait], :cost => wait_cost(hash[:wait]).round(2)},
      :total => km_cost(hash[:kms]).round(2) + wait_cost(hash[:wait]).round(2)
    }
  end

  def km_cost(kms)
    @_kms ||= {}
    @_kms[kms] ||= km_scheme.calculate(kms) 
  end

  def wait_cost(hrs)
    @_wait_cost ||= {}
    @_wait_cost[hrs] ||= wait_scheme.calculate(hrs * 60)
  end

  def wait_speed
    wait_scheme.wait_speed
  end

  def valid?
    km_scheme.valid? && wait_scheme.valid?
  end


  private

  attr_reader :km_scheme, :wait_scheme


  
end
