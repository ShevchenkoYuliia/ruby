require 'net/http'
require 'json'
require 'csv'
require 'uri'

api_key = 'e9814d83a32aa54ece44c470'
base_currency = 'USD'  
url = "https://v6.exchangerate-api.com/v6/#{api_key}/latest/#{base_currency}"

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
  
  puts 'Data saved to file exchange_rates.csv'
else
  puts "Error: #{data['error-type']}"
end
