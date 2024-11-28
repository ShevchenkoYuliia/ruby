require 'net/http'
require 'uri'

def perform_request(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  puts "URL: #{url}, Status: #{response.code}, Response length: #{response.body.size}"
rescue StandardError => e
  puts "URL: #{url}, Error: #{e.message}"
end

urls = [
  "https://www.ruby-lang.org/en/documentation/",
  "https://www.ruby-lang.org/en/libraries/",
  "https://www.ruby-lang.org/en/community/",
  "https://www.ruby-lang.org/en/about/",
  "https://www.ruby-lang.org/en/news/"
]

threads = []

urls.each do |url|
  threads << Thread.new { perform_request(url) }
end

threads.each(&:join)

puts "All requests are complete!"
