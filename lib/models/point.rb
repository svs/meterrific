class Point

  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :lat, Decimal, :precision => 18, :scale => 15, :required => true, :max => 90, :min => -90
  property :lng, Decimal, :precision => 18, :scale => 15, :required => true, :max => 180, :min => -180

  belongs_to :cabmeter

end
