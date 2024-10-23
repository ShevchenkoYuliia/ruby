# frozen_string_literal: true

require_relative "even_filter/version"

module EvenFilter
  def self.filter(array)
    array.select { |num| num.even? }
  end
end
