require 'rspec'

RSpec.describe 'Multithreaded File Processing' do
  let(:input_file) { 'input.txt' }
  let(:output_file) { 'output.txt' }

  before do
    File.open(input_file, 'w') do |file|
      (1..10).each { |i| file.puts(i) }
    end
  end

  after do
    File.delete(input_file) if File.exist?(input_file)
    File.delete(output_file) if File.exist?(output_file)
  end

  it 'correctly writes the squares of numbers to the output file' do
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

    expected_output = (1..10).map { |n| n**2 }
    actual_output = File.readlines(output_file).map(&:to_i)

    expect(actual_output).to eq(expected_output)
  end
end
