require 'rspec'
require 'net/http'
require 'json'
require 'csv'
require 'uri'
require_relative 'currency_fetcher'

module Net
  class HTTP
    def self.get(uri)
      '{"result":"success","conversion_rates":{"EUR":0.85,"GBP":0.75,"JPY":110.0}}'
    end
  end
end

describe 'Exchange Rate API' do
  let(:api_key) { 'KEY' }
  let(:base_currency) { 'USD' }
  let(:url) { "https://v6.exchangerate-api.com/v6/#{api_key}/latest/#{base_currency}" }
  

  it 'fetches exchange rates and saves to CSV' do
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    if data['result'] == 'success'
      rates = data['conversion_rates']
      
      CSV.open('exchange_rates.csv', 'wb') do |csv|
        csv << ['Currency', 'Rate'] 
        rates.each do |currency, rate| 
          csv << [currency, rate] 
        end
      end
    end

    expect(File).to exist('exchange_rates.csv')

    csv_data = CSV.read('exchange_rates.csv')
    expect(csv_data).to include(['Currency', 'Rate'])
    expect(csv_data).to include(['EUR', '0.85'])
    expect(csv_data).to include(['GBP', '0.75'])
    expect(csv_data).to include(['JPY', '110.0'])

    File.delete('exchange_rates.csv') if File.exist?('exchange_rates.csv')
  end
end
