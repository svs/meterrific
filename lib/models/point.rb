require_relative '../haversine.rb'
class Point


  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :lat, Decimal, :precision => 18, :scale => 15, :required => true, :max => 90, :min => -90
  property :lng, Decimal, :precision => 18, :scale => 15, :required => true, :max => 180, :min => -180
  
  property :speed, Float
  property :distance, Float

  before :save, :calculate_diff_from_previous_point

  belongs_to :cab_meter, :required => false

  def -(other)
    distance = other ? Haversine.coorDist(self.lat, self.lng, other.lat, other.lng).round(5) : 0
    time = other ? ((self.created_at - other.created_at).to_f * 24).round(4) : 0 # hours to 4 decimal places
    OpenStruct.new(:time => time,
                   :distance => distance,
                   :speed => ((distance/time).round(4) rescue 0))
  end

  private

  def calculate_diff_from_previous_point
    self.distance = diff_from_previous_point.distance
    self.speed = diff_from_previous_point.speed
  end

  def diff_from_previous_point
    @_d ||= (self - previous_point)
  end

  def previous_point
    self.id.nil? ? siblings.last : siblings.first(:order => [:id.desc], :id.lt => self.id)
  end

  def siblings
    Point.all(:cab_meter_id => self.cab_meter_id)
  end


end
