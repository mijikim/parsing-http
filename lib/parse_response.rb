class HTTPResponseParser

  def initialize(string)
    @string = string
  end

  def response_code
    @string.split(" ")[1].to_i
  end

  def version
    @string.split(" ")[0]
  end

  def body
    @string[@string.index("<")..-1].delete("\n")
  end

  def header
    hash = {}
    array = @string[0...@string.index("<")].split("\n")
    array[1..-1].each {|line|
    split_array = line.split(": ")
    hash[split_array[0] + ":"] = split_array[1]
    }
    hash
  end

  def content_type
    header["Content-Type:"]
  end

  def server
    header["Server:"]
  end

  def location
    header["Location:"]
  end

end