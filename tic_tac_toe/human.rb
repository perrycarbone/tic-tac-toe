class Human
  attr_accessor :marker

  def choose_marker
    selected_marker = nil
    loop do
      puts "Choose a marker ('X', or 'O'):"
      selected_marker = gets.chomp
      break if %w(X O).include?(selected_marker)
      puts "Must be 'X', or 'O'."
    end
    selected_marker
  end

  def move(board)
    position = nil
    loop do
      puts 'Choose a position (1-9):'
      position = gets.chomp.to_i
      break if board.empty_positions.include?(position)
    end
    board.mark_square(position, marker)
  end
end
