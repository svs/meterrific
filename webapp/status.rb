module StatusController 

  class Index < ControllerAction
    def get
      succeed_with "OK"
    end
  end

end
