module ApiKeysController

  class Index < ControllerAction

    def post
      @api_key = ApiKey.new(:email => params[:email])
      @api_key.save ? succeed_with(JSON.dump(@api_key.attributes)) : fail_with(JSON.dump(@api_key.errors.to_hash), 422)
    end

  end

end
