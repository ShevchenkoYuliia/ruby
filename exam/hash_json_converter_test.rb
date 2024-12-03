require 'rspec'
require 'json'
require_relative 'hash_json_converter'
RSpec.describe 'JSON Conversion' do
  let(:hash_example) { { name: "Jack", age: 30, skills: ["Ruby", "JavaScript"] } }
  let(:json_example) { '{"name":"Jack","age":30,"skills":["Ruby","JavaScript"]}' }

  def stringify_keys(hash)
    hash.transform_keys(&:to_s)
  end

  describe '#hash_to_json' do
    it 'converts a hash to a JSON string' do
      expect(hash_to_json(hash_example)).to eq(json_example)
    end
  end

  describe '#json_to_hash' do
    it 'converts a JSON string to a hash' do
      expect(json_to_hash(json_example)).to eq(stringify_keys(hash_example))
    end
  end

  describe 'Integration test' do
    it 'converts hash to JSON and back to hash correctly' do
      json_result = hash_to_json(hash_example)
      hash_result = json_to_hash(json_result)
      expect(hash_result).to eq(stringify_keys(hash_example))
    end
  end
end