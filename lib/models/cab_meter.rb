require 'securerandom'
require_relative '../domain/scheme.rb'
require_relative 'point.rb'

class CabMeter

  include DataMapper::Resource

  property :id, Serial

  property :scheme, Json, :lazy => false
  property :read_only_id, String, :length => 200
  property :write_id, String, :length => 200

  property :state, String

  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :points
  belongs_to :api_key

  before :create, :make_urls


  validates_with_method :scheme, :method => :valid_scheme?

  def started?
    state == "started"
  end

  def startable?
    !started? && !stopped?
  end

  def stoppable?
    started?
  end

  def start!
    startable? ? (self.state = "started" and save!) : self.errors.add(:start, "Cannot start this trip")  

  end

  def stop!
    self.state = "stopped" and save!
  end

  def stopped?
    self.state == "stopped"
  end


  def add_point(point)
    raise "Meter not started" unless started?
    self.points << point and self.save and self.reload    
  end

  def attributes
    super.except(:created_at, :updated_at)
  end

  private

  def valid_scheme?
    return [false, "Scheme is not valid"] unless Scheme.new(scheme).valid?
    return true
  end

  def make_urls
    self.write_id = SecureRandom.urlsafe_base64(25)
    self.read_only_id = SecureRandom.urlsafe_base64(25)
  end


end
