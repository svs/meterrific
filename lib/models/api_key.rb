require 'securerandom'
class ApiKey

  include DataMapper::Resource

  attr_accessor :new_key, :old_key

  property :id, Serial

  property :api_key, String, :length => 200
  property :email, String, :format => :email_address, :unique => true

  before :create, :make_key
  before :api_key=, :get_current_api_key
  validates_with_method :api_key, :method => :old_key_provided?
  private

  def make_key
    self.api_key = SecureRandom.urlsafe_base64(50)
  end

  def old_key_provided?
    return true if self.new?
    return [false, "Please provide the old API key in order to update it"] unless self.old_key == @current_api_key
    return true
  end

  def get_current_api_key
    @current_api_key = self.api_key
  end
    


end
  
