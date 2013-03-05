require 'active_support/core_ext/string/inflections'

class Path

  attr_reader :request
  
  def initialize(request)
    @request = OpenStruct.new(request)
  end

  # returns 
  def action
    (action_selector[type] || {}).fetch(method, nil) || url_array[-1].camelize
  end


  def controller
    "#{url_array[0].camelize}Controller".constantize
  end
  

   
  # returns 1 when url_array == ['foo','bar','1']
  # given(:url_array => ['foo','bar']) { method(:id).returns :nil }
  def id
    url_array.map(&:to_i).select{|i| i > 0}.first
  end

  private
  
  attr_accessor :request

  def has_id?
    url_array[1].to_i > 0
  end

  def index?
    url_array.size == 1
  end

  def member?
    url_array.size == 2 && has_id?
  end

  def type
    index? ? "index" : (member? ? "member" : "other")
  end


  def action_selector
    {
      "index" => {"GET" => "Index", "POST" => "Index"},
      "member" => {"GET" => "Show", "POST" => "Update", "DELETE" => "Delete"},
    }
  end

  def url_array
    request.path.split("/").reject(&:empty?)
  end

  def method
    request.request_method
  end

  def to_s
    "#{request.request_method} #{request.path}"
  end

end



