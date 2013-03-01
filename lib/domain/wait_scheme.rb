class WaitScheme

  def initialize(scheme)
    @scheme = scheme
  end

  def valid?
    scheme.has_key?(:per_minute) && scheme.has_key?(:wait_speed)
  end

  private

  attr_reader :scheme
end
