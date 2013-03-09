module CabMetersController

  class Index < ControllerAction

    default_format :json

    def get
      @cab_meters = CabMeter.all(:api_key => ApiKey.first(:key => params[:key]))
    end

    def post
      @api_key = ApiKey.first(:api_key => params[:api_key])
      return fail_with(JSON.dump({:errors => "invalid API key"}), 401) unless @api_key
      @cab_meter = CabMeter.new(params[:cab_meter].merge(:api_key => @api_key))
      @cab_meter.save ? succeed_with(JSON.dump(@cab_meter.attributes)) : fail_with(JSON.dump(@cab_meter.errors.to_hash), 422)
    end
  end


  class Start < ControllerAction

    def post
      @cab_meter = CabMeter.first(:write_id => params[:id])
      return fail_with(JSON.dump({:errors => "invalid API key"}, 401)) unless @cab_meter
      @cab_meter.start! ? succeed_with(JSON.dump(@cab_meter.attributes)) : fail_with(JSON.dump(@cab_meter.errors.to_hash), 422)
    end
  end

  class Stop < ControllerAction
    def post
      @cab_meter = CabMeter.first(:write_id => params[:id])
      return fail_with(JSON.dump({:errors => "invalid API key"}, 401)) unless @cab_meter
      @cab_meter.stop! ? succeed_with(JSON.dump(@cab_meter.attributes)) : fail_with(JSON.dump(@cab_meter.errors.to_hash), 422)
    end
  end

  class Mark < ControllerAction

    def post
      @cab_meter = CabMeter.first(:write_id => params[:id])
      return fail_with(JSON.dump({:errors => "invalid API key"}, 401)) unless @cab_meter
      @point = Point.new(params[:point].merge(:cab_meter => @cab_meter))
      @point.save ? succeed_with(JSON.dump(@point.attributes)) : fail_with(@point.errors.to_hash, 422)
    end

  end


  class Read < ControllerAction

    def get
      @cab_meter = CabMeter.first(:read_only_id => params[:id])
      return fail_with(JSON.dump({:errors => "invalid read id"}, 401)) unless @cab_meter
      succeed_with JSON.dump(MeterReading.new(@cab_meter).calculate())
    end

  end


end

  
    
