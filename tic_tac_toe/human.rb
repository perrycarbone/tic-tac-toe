class Human < Player

  def initialize
    super
  end

  def move(board)
    position = nil
    loop do
      puts 'Choose a position (1-9):'
      position = gets.chomp.to_i
      break if chose_empty_position?(board, position)
    end
    super(board, position, marker)
  end

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

  private

  def chose_empty_position?(board, position)
    board.empty_positions.include?(position)
  end
end
