require_relative 'track.rb'

class MeterReading

  # Calculates the end results for a cab_meter

  def initialize(cab_meter)
    @cab_meter = cab_meter
    @track = Track.new(cab_meter.points)
  end

  def calculate
    scheme.calculate(track_results)
  end


  private

  attr_accessor :cab_meter, :track

  def scheme
    Scheme.new(cab_meter.scheme)
  end

  def track_results
    {:kms => track.kms, :wait => track.wait(scheme.wait_speed)}
  end
    
end
