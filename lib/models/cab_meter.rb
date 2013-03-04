require_relative '../domain/scheme.rb'
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


  validates_with_method :scheme, :method => :valid_scheme?

  private

  def valid_scheme?
    return [false, "Scheme is not valid"] unless Scheme.new(scheme).valid?
    return true
  end


end
