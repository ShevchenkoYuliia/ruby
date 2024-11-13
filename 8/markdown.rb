require 'fileutils'

def convert_to_markdown(input_file, output_file)
  begin
    content = File.read(input_file)
    
    markdown_content = "# Converted Markdown Document\n\n" + content

    File.open(output_file, 'w') do |file|
      file.write(markdown_content)
    end

    puts "Conversion completed successfully! The output file is: #{output_file}"
  rescue Errno::ENOENT
    puts "Error: The file '#{input_file}' does not exist."
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

puts "Enter the path of the input text file:"
input_file = gets.chomp

puts "Enter the desired path for the output Markdown file:"
output_file = gets.chomp

convert_to_markdown(input_file, output_file)
