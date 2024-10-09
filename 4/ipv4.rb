def valid_ipv4(ip)
  ip = ip.strip

  return false unless ip.match?(/^\d+(\.\d+){0,3}$/)

  parts = ip.split('.')
  
  return false unless parts.length == 4

  parts.all? do |part|
    part.match?(/^\d+$/) && part.to_i.between?(0, 255) && part == part.to_i.to_s
  end
end

puts "input -> "
num = gets.chomp  

if valid_ipv4(num)
  puts "#{num} is a valid IPv4 address"
else
  puts "#{num} is not a valid IPv4 address"
end