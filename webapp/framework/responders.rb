class Response

  def initialize(body, format, status, headers = {})
    @body, @format, @status = body, format, status
    @headers = {"Content-Type" => "text/#{format}", "Access-Control-Allow-Origin" => "*"}.merge(headers)
  end
  def to_a
    [@status, @headers, @body]
  end
end

class Success < Response
  def initialize(body, format = "html", status = 200, headers = {})
    super(body, format, status, headers)
  end
end


class Failure < Response
  def initialize(body, format = "html", status = 400, headers = {})
    super(body, format, status, headers)
  end
end

