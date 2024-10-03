class Handler
  attr_accessor :next_handler

  def initialize(next_handler = nil)
    @next_handler = next_handler
  end

  def handle_request(request)
    if can_handle?(request)
      process_request(request)
    elsif @next_handler
      @next_handler.handle_request(request)
    else
      puts "Request '#{request}' cannot be handled."
    end
  end

  def can_handle?(request)
    false
  end

  def process_request(request)
    puts "Handling request: #{request}"
  end
end

class ConcreteHandlerA < Handler
  def can_handle?(request)
    request == "A"
  end

  def process_request(request)
    puts "ConcreteHandlerA processing request: #{request}"
  end
end

class ConcreteHandlerB < Handler
  def can_handle?(request)
    request == "B"
  end

  def process_request(request)
    puts "ConcreteHandlerB processing request: #{request}"
  end
end

class ConcreteHandlerC < Handler
  def can_handle?(request)
    request == "C"
  end

  def process_request(request)
    puts "ConcreteHandlerC processing request: #{request}"
  end
end

handler_c = ConcreteHandlerC.new
handler_b = ConcreteHandlerB.new(handler_c)
handler_a = ConcreteHandlerA.new(handler_b)

requests = ["A", "B", "C", "D"]
requests.each do |request|
  puts "\nSending request: #{request}"
  handler_a.handle_request(request)
end
