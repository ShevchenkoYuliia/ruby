require 'minitest/autorun'
require_relative '../lib/even_filter'

class EvenFilterTest < Minitest::Test
  def test_filter
    assert_equal [2, 4, 6], EvenFilter.filter([1, 2, 3, 4, 5, 6])
  end
end