def find_raisins(cake)
  raisins = []
  cake.each_with_index do |row, y|
    row.chars.each_with_index do |char, x|
      raisins << [y, x] if char == 'o'
    end
  end
  raisins
end

def slice_cake(cake, raisins)
  slices = []
  raisins.each_with_index do |(ry, rx), index|
    if index == 0
      top = 0
    else
      top = raisins[index - 1][0] + 1
    end

    bottom = (index == raisins.size - 1) ? cake.size - 1 : ry

    slice = cake[top..bottom]
    slices << slice
  end

  slices
end

def print_cake(cake)
  cake.each { |row| puts row }
end

def solve_cake(cake)
  raisins = find_raisins(cake)

  return [] if raisins.empty?

  slices = slice_cake(cake, raisins)

  slices.each_with_index do |slice, index|
    puts "Slice #{index + 1}:"
    print_cake(slice)
    puts "-" * 20
  end

  slices
end

cake = [
  '........',
  '..o.....',
  '...o....',
  '........'
]

cake1 = [
  '.o......',
  '......o.',
  '....o...',
  '..o.....'
]

cake2 = [
  '........',
  '........',
  '....o...',
  '........',
  '.....o..',
  '........'
]

solve_cake(cake)
puts "\n"
solve_cake(cake1)
puts "\n"
solve_cake(cake2)
puts "\n"