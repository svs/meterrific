class WaitScheme

  def initialize(scheme)
    @scheme = scheme
  end

  def valid?
    scheme.has_key?(:per_minute) && scheme.has_key?(:wait_speed)
  end

  def calculate(hours)
    raise "Not a valid wait scheme" unless valid?
    hours * 60 * scheme[:per_minute]
  end

  def wait_speed
    scheme[:wait_speed]
  end

  private

  attr_reader :scheme
end
