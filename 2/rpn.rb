def reverse_polish_notation(line)
  result_line = []
  operators = []

  precedence = { '+' => 1, '-' => 1, '*' => 2, '/' => 2, '^' => 3 }

  symbols = line.scan(/\d+|\+|\-|\*|\/|\^|\(|\)/)

  symbols.each do |symbol|
    if symbol >= '0' && symbol <= '9' 
      result_line << symbol
    elsif symbol == '('
      operators.push(symbol)
    elsif symbol == ')'
      while operators.last != '('
        result_line << operators.pop
      end
      operators.pop  
    elsif precedence.keys.include?(symbol)  
      while operators.any? && precedence[operators.last] && precedence[operators.last] >= precedence[symbol]
        result_line << operators.pop
      end
      operators.push(symbol)
    end
  end

  while operators.any?
    result_line << operators.pop
  end

  puts "result -> #{result_line.join(' ')}"
end

puts "input -> "
entered_line = gets.chomp  
reverse_polish_notation(entered_line)