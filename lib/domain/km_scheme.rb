class KmScheme

  # validates the kms part of the cab meter scheme and calculates the cost for kms travelled

  def initialize(scheme)
    @scheme = scheme
  end

  def calculate(kms)
    raise "Invalid Scheme" unless valid?
    weighted_average(kms_by_step(kms).zip(rates_by_step))
  end

  def valid?
    all_but_last_step.map{|k,v| Integer(k) rescue nil}.all?
  end

  private

  attr_reader :scheme

  def last_step
    steps[-1]
  end

  def all_but_last_step
    steps.length >= 2 ? steps[0..-2] : []
  end

  def steps
    return scheme if scheme.class == Array
    return scheme.to_a if scheme.class == Hash
    return [["then", Integer(scheme)]]
  end

  def kms_by_step(kms)
    all_but_last_step.map do |k, _| 
      [kms, k.to_i].min.tap {|y| kms -= y }
    end + [kms]
  end

  def rates_by_step
    steps.map{|kms, rate| rate.to_i }
  end
    
  def weighted_average(array)
    array.reduce(0){|total, i| total += i[0] * i[1]}
  end
  

end
