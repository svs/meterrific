class ControllerAction

  attr_accessor :env

  
  def initialize(router)
    @router = router
    @env = router.env
    @params, @url = router.params, router.url
    @format = @params.delete(:format) || self.class.default_format
  end

  def self.default_format(format = nil)
    @@default_format = format if format
    @@default_format || "json"
  end


  private

  attr_reader :format
  
  def id
    params[:id]
  end

  def params
    @params
  end

  def merge!(hash)
    @router.tap{|r| r.params.merge!(hash) }
  end

  def respond_with(body, status, headers = {})
    Response.new(body, format, status, headers).to_a
  end

  def succeed_with(body, status = 200)
    Success.new(body, format).to_a
  end

  def fail_with(body, status = 400)
    Failure.new(body, format, status).to_a
  end

  def check_auth!
    throw(:warden) unless env['warden'].authenticated?
  end

  def authorised_to(action, model)
    current_ability.can?(action, model)
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def current_user
    @current_user ||= env['warden'].user
  end



end
