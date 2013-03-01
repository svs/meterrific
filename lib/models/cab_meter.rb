require_relative '../domain/scheme_validator'
require_relative 'point.rb'

class CabMeter

  include DataMapper::Resource

  property :id, Serial

  property :scheme, Json
  property :read_only_id, String, :length => 200
  property :write_id, String, :length => 200

  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :points

  before :create, :make_urls


  validates_with_method :scheme, :valid_scheme?

end
