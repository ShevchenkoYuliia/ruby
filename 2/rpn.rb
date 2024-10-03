def reverse_polish_notation(line)
  result_line = []
  operators = []

  precedence = { '+' => 1, '-' => 1, '*' => 2, '/' => 2, '^' => 3 }

  symbols = line.scan(/-?\d+\.?\d*|\+|\-|\*|\/|\^|\(|\)/)

  symbols.each do |symbol|
    if symbol =~ /^-?\d+\.?\d*$/
      result_line << symbol
    elsif symbol == '('
      operators.push(symbol)
    elsif symbol == ')'
      while operators.any? && operators.last != '('
        result_line << operators.pop
      end
      operators.pop
      if operators.empty? || operators.last == '('
        puts "Error: Unbalanced parentheses."
        return
      end
    elsif precedence.keys.include?(symbol)
      while operators.any? && precedence[operators.last] && precedence[operators.last] >= precedence[symbol]
        result_line << operators.pop
      end
      operators.push(symbol)
    else
      puts "Error: Unsupported operation or invalid symbol: #{symbol}"
      return
    end
  end

  while operators.any?
    if operators.last == '('
      puts "Error: Unbalanced parentheses."
      return
    end
    result_line << operators.pop
  end

  puts "RPN result -> #{result_line.join(' ')}"
  evaluate_rpn(result_line)
end

def evaluate_rpn(rpn)
  stack = []

  rpn.each do |token|
    if token =~ /^-?\d+\.?\d*$/
      stack.push(token.to_f)
    else
      b = stack.pop
      a = stack.pop

      if token == '/' && b == 0
        puts "Error: Division by zero."
        return
      end

      result = case token
               when '+' then a + b
               when '-' then a - b
               when '*' then a * b
               when '/' then a / b
               when '^' then a ** b
               end
      stack.push(result)
    end
  end

  if stack.size != 1
    puts "Error: Invalid expression."
end

puts "input -> "
entered_line = gets.chomp  
reverse_polish_notation(entered_line)
