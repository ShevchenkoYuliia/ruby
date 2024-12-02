def find_raisins_positions(cake) 
  positions = []
  cake.each_with_index do |row, i|
    row.chars.each_with_index do |cell, j|
      positions << [i, j] if cell == 'o'
    end
  end
  positions
end

def generate_rectangles(raisin, slice_area, rows, cols)
  rectangles = []
  x, y = raisin
  (1..slice_area).each do |height|
    next unless slice_area % height == 0
    width = slice_area / height
    next if width > cols || height > rows

    ((x - height + 1)..x).each do |top|
      ((y - width + 1)..y).each do |left|
        next if top < 0 || left < 0 || top + height > rows || left + width > cols
        if x.between?(top, top + height - 1) && y.between?(left, left + width - 1)
          rectangles << [[top, left], [top + height - 1, left + width - 1]]
        end
      end
    end
  end
  rectangles
end

def max_first_width_solution(solutions)
  solutions.max_by { |solution| solution.first[1][1] - solution.first[0][1] + 1 }
end
def valid_partition?(rectangles, raisins)
  covered_raisins = []
  covered_cells = {}

  rectangles.each do |(top_left, bottom_right)|
    top, left = top_left
    bottom, right = bottom_right

    raisins.each do |raisin|
      x, y = raisin
      if x.between?(top, bottom) && y.between?(left, right)
        return false if covered_raisins.include?(raisin) 
        covered_raisins << raisin
      end
    end

    (top..bottom).each do |i|
      (left..right).each do |j|
        return false if covered_cells[[i, j]] 
        covered_cells[[i, j]] = true
      end
    end
  end

  covered_raisins.sort == raisins.sort
end

def split_cake(cake)
  rows = cake.length
  cols = cake[0].length
  raisins = find_raisins_positions(cake)
  slice_area = (rows * cols) / raisins.size

  return nil unless (rows * cols) % raisins.size == 0

  all_rectangles = raisins.map { |raisin| generate_rectangles(raisin, slice_area, rows, cols) }
  solutions = all_rectangles.first.product(*all_rectangles[1..-1]).select do |combination|
    valid_partition?(combination, raisins)
  end
  puts "Raisins found: #{raisins.inspect}"
  puts "Slice area: #{slice_area}"
  raise "Raisin count must be between 1 and 10"  if raisins.size <= 1 || raisins.size >= 10
  raise "Invalid cake dimensions or raisin count" unless (rows * cols) % raisins.size == 0
  max_first_width_solution(solutions)
end
def visualize_pieces(cake, solution)
  pieces = []

  solution.each do |(top_left, bottom_right)|
    top, left = top_left
    bottom, right = bottom_right

    piece = []
    (top..bottom).each do |i|
      row = cake[i][left..right]
      piece << row
    end
    pieces << piece
  end

  pieces
end
def print_solution(cake)
  puts cake
  solution2 = split_cake(cake)
  if solution2.nil? || solution2.empty?
    puts "No valid solution found for the cake."
  else
    puts "Solution Coordinates:"
    solution2.each do |(top_left, bottom_right)|
      puts "#{top_left} -> #{bottom_right}"
    end

    puts "\nVisualized Cake Pieces:"
    visualized_pieces = visualize_pieces(cake, solution2)
    visualized_pieces.each_with_index do |piece, index|
      puts "Piece #{index + 1}:"
      piece.each { |row| puts row }
      puts
    end
  end
end
cake = [
  ".o......",
  "......o.",
  "....o...",
  "..o....."
]
cake1 = [
  '........',
  '..o.....',
  '...o....',
  '........'
]
cake2 = [
  ".o.o....",
  "........",
  "....o...",
  "........",
  ".....o..",
  "........"
]
cake3 = [
  "....",
  ".oo.",
  "....",
  ".oo."
]
cake4 = [
  "o.....",
  "......",
  ".....o",
  "......",
  "..o..."
]
cake5 = [
  ".....",
  ".....",
  "..o..",
  ".....",
  "....."
]
cake6 = [
  ".o...",
  "....o",
  "..o..",
  ".....",
  "o...."
]
puts "Cake 1"
print_solution(cake)
puts "Cake 2"
print_solution(cake1) 
puts "Cake 3"
print_solution(cake2) 
puts "Cake 4"
print_solution(cake3) 
puts "Cake 5"
print_solution(cake4) 
#puts "Cake 6"
#print_solution(cake5) 
