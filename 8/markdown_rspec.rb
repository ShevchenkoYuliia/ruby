require_relative 'markdown'
describe 'convert_to_markdown' do
  before(:each) do
    @input_file = 'test_input.txt'
    @output_file = 'test_output.md'
    File.write(@input_file, "This is a test content.")
  end

  after(:each) do
    File.delete(@input_file) if File.exist?(@input_file)
    File.delete(@output_file) if File.exist?(@output_file)
  end

  it 'creates a markdown file with proper formatting' do
    convert_to_markdown(@input_file, @output_file)
    output_content = File.read(@output_file)
    expected_content = "# Converted Markdown Document\n\nThis is a test content."
    expect(output_content).to eq(expected_content)
  end

  it 'handles missing input file error' do
    expect { convert_to_markdown('nonexistent.txt', @output_file) }.to output(/Error: The file 'nonexistent.txt' does not exist./).to_stdout
  end
end