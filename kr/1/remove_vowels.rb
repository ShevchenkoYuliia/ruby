def remove_vowels(str)
  str.delete('aeiouAEIOUаеєиіїоуюяАЕЄИІЇОУЮЯ')
end
puts "Write string:"
str = gets.chomp
puts remove_vowels(str)