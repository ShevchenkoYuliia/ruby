require 'json'

def hash_to_json(hash)
  hash.to_json
end

def json_to_hash(json_string)
  JSON.parse(json_string)
end

hash_example = { name: "Jack", age: 30, skills: ["Ruby", "JavaScript"] }
puts "Original hash:"
p hash_example

json_result = hash_to_json(hash_example)
puts "\nHash to JSON:"
puts json_result


hash_result = json_to_hash(json_result)
puts "\nJSON to Hash:"
p hash_result
