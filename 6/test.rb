require_relative '../gem/even_filter/lib/even_filter'
require 'bundler/setup'
puts EvenFilter.filter([1, 2, 3, 4, 5, 6])
