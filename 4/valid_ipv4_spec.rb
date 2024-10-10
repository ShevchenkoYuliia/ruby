require 'rspec'

def valid_ipv4(ip)
  ip = ip.strip

  return false unless ip.match?(/^\d+(\.\d+){0,3}$/)

  parts = ip.split('.')
  
  return false unless parts.length == 4

  parts.all? do |part|
    part.match?(/^\d+$/) && part.to_i.between?(0, 255) && part == part.to_i.to_s
  end
end

RSpec.describe 'valid_ipv4' do
  it 'returns true for valid IPv4 addresses' do
    expect(valid_ipv4('192.168.0.1')).to be true
    expect(valid_ipv4('0.0.0.0')).to be true
    expect(valid_ipv4('255.255.255.255')).to be true
    expect(valid_ipv4('127.0.0.1')).to be true
  end

  it 'returns false for invalid IPv4 addresses' do
    expect(valid_ipv4('256.100.50.25')).to be false  
    expect(valid_ipv4('192.168.1')).to be false   
    expect(valid_ipv4('192.168.1.300')).to be false  
    expect(valid_ipv4('192.168.1.-1')).to be false   
    expect(valid_ipv4('192.168.1.1.1')).to be false   
    expect(valid_ipv4('hello.world')).to be false     
    expect(valid_ipv4('')).to be false                 
    expect(valid_ipv4('  192.168.1.1  ')).to be true   
  end

  it 'handles edge cases' do
    expect(valid_ipv4('01.02.03.04')).to be false      
    expect(valid_ipv4('192.168.0.256')).to be false    
    expect(valid_ipv4('192.168.0.0.0')).to be false     
    expect(valid_ipv4('192.168.0.-1')).to be false
  end
end
