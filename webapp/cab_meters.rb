module CabMetersController

  class Index < ControllerAction

    default_format :json

    def get
      @cab_meters = CabMeter.all(:api_key => ApiKey.first(:key => params[:key]))
    end

    def post
      @api_key = ApiKey.first(:api_key => params[:api_key])
      return fail_with(JSON.dump({:errors => "invalid API key"}, 401)) unless @api_key
      @cab_meter = CabMeter.new(params[:cab_meter])
      @cab_meter.save ? succeed_with(JSON.dump(@cab_meter.attributes)) : fail_with(JSON.dump(@cab_meter.errors.to_hash), 422)
    end
  end

end

  
    
