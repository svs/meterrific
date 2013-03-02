class WaitScheme

  def initialize(scheme)
    @scheme = scheme
  end

  def valid?
    scheme.has_key?(:per_minute) && scheme.has_key?(:wait_speed)
  end

  def calculate(minutes)
    raise "Not a valid wait scheme" unless valid?
    minutes * scheme[:per_minute]
  end

  private

  attr_reader :scheme
end
