require 'thread'

File.open('input.txt', 'w') do |file|
  10.times { file.puts rand(1..20) }
end
input_file = 'input.txt'
output_file = 'output.txt'
queue = Queue.new
reader_thread = Thread.new do
  File.foreach(input_file) do |line|
    queue.push(line.to_i)
  end
  queue.push(nil) 
end

writer_thread = Thread.new do
  File.open(output_file, 'w') do |file|
    loop do
      number = queue.pop
      break if number.nil?

      file.puts(number**2)
    end
  end
end

reader_thread.join
writer_thread.join

puts "The square number is written to the file #{output_file}"
