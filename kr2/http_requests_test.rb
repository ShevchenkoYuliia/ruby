require 'rspec'
require 'webmock/rspec'
require_relative 'http_requests'

RSpec.describe 'perform_request' do
  before do
    stub_request(:get, "https://www.ruby-lang.org/en/documentation/")
      .to_return(status: 200, body: "Documentation content", headers: {})
    stub_request(:get, "https://www.ruby-lang.org/en/libraries/")
      .to_return(status: 200, body: "Libraries content", headers: {})
    stub_request(:get, "https://www.ruby-lang.org/en/community/")
      .to_return(status: 200, body: "Community content", headers: {})
    stub_request(:get, "https://www.ruby-lang.org/en/about/")
      .to_return(status: 404, body: "Not Found", headers: {})
    stub_request(:get, "https://www.ruby-lang.org/en/news/")
      .to_return(status: 500, body: "Internal Server Error", headers: {})
  end

  it 'performs requests and logs the results' do
    urls = [
      "https://www.ruby-lang.org/en/documentation/",
      "https://www.ruby-lang.org/en/libraries/",
      "https://www.ruby-lang.org/en/community/",
      "https://www.ruby-lang.org/en/about/",
      "https://www.ruby-lang.org/en/news/"
    ]

    expect {
      threads = []
      urls.each do |url|
        threads << Thread.new { perform_request(url) }
      end
      threads.each(&:join)
      puts "All requests are complete!"
    }.to output(
      a_string_including(
        "URL: https://www.ruby-lang.org/en/documentation/, Status: 200, Response length: 21",
        "URL: https://www.ruby-lang.org/en/libraries/, Status: 200, Response length: 17",
        "URL: https://www.ruby-lang.org/en/community/, Status: 200, Response length: 17",
        "URL: https://www.ruby-lang.org/en/about/, Status: 404, Response length: 9",
        "URL: https://www.ruby-lang.org/en/news/, Status: 500, Response length: 21",
        "All requests are complete!"
      )
    ).to_stdout
  end
end
