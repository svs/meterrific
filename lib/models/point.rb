require_relative '../haversine.rb'
class Point


  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :lat, Decimal, :precision => 18, :scale => 15, :required => true, :max => 90, :min => -90
  property :lng, Decimal, :precision => 18, :scale => 15, :required => true, :max => 180, :min => -180

  belongs_to :cab_meter, :required => false

  def -(other)
    distance = Haversine.coorDist(self.lat, self.lng, other.lat, other.lng).round(5)
    time = ((self.created_at - other.created_at).to_f * 24).round(4) # hours to 4 decimal places
    OpenStruct.new(:time => time,
                   :distance => distance,
                   :speed => distance/time)
  end


end
