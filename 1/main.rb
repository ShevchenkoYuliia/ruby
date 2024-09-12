def play(user_choice)
    choices = ["Rock", "Scissors", "Paper"]
    puts "Your choice: #{choices[user_choice]}"
    computer_choice = rand(3)
    puts "Computer choice: #{choices[computer_choice]}"
    if computer_choice == user_choice
        puts "It's a draw! Try again."
    elsif (computer_choice == 0 && user_choice == 1 ) || 
        (computer_choice == 2 && user_choice == 0) || 
        (computer_choice == 1 && user_choice == 2)
        puts "Fail! You lose!"
    else puts "Congratulations! You win!"
    end
end

puts 'Welcome to the game "Rock, Scissors, Paper"'
puts "0 - rock, 1 - scissors, 2 - paper"
puts "Choose a number: "
choice = gets.to_i
if choice.between?(0, 2)
    play(choice)
  else
    puts "Invalid choice. Please choose 0, 1, or 2."
  end