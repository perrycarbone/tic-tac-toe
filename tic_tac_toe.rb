class Board
  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  def all_squares_marked?
    empty_squares.size == 0
  end

  def draw
    puts
    puts '      |      |'
    puts "   #{squares[1].value}  |   #{squares[2].value}  |   #{squares[3].value}"
    puts '      |      |'
    puts '------+------+------'
    puts '      |      |'
    puts "   #{squares[4].value}  |   #{squares[5].value}  |   #{squares[6].value}"
    puts '      |      |'
    puts '------+------+------'
    puts '      |      |'
    puts "   #{squares[7].value}  |   #{squares[8].value}  |   #{squares[9].value}"
    puts '      |      |'
    puts
  end

  def empty_squares
    squares.select { |_, square| square.value == ' ' }.values
  end

  def empty_positions
    squares.select { |_, square| !square.occupied? }.keys
  end

  def mark_square(position, marker)
    squares[position].mark(marker)
  end

  def reset
    (1..9).each { |position| squares[position] = Square.new(' ') }
  end

  def winner?
    !!winning_marker
  end

  def winning_marker
    return row_winner if row_winner
    return column_winner if column_winner
    return forward_diagonal_winner if forward_diagonal_winner
    return reverse_diagonal_winner if reverse_diagonal_winner
    nil
  end

  private

  def build_column(column_index)
    rows.each_with_object([]) { |row, column| column << row[column_index] }
  end

  def column_winner
    columns.each do |column|
      return column.first if column.uniq.length == 1 && column.first != ' '
    end
    nil
  end

  def columns
    result = []
    column_index = 0
    (rows.first.length).times do
      result << build_column(column_index)
      column_index += 1
    end
    result
  end

  def forward_diagonal
    result = []
    coordinate = 0
    (length_of_board).times do
      result << rows[coordinate][coordinate]
      coordinate += 1
    end
    result
  end

  def forward_diagonal_winner
    if forward_diagonal.uniq.length == 1 &&
       forward_diagonal.first != ' '
      return forward_diagonal.first
    end
    nil
  end

  def length_of_board
    rows.first.length
  end

  def reverse_diagonal
    result = []
    first_coordinate = 0
    second_coordinate = length_of_board - 1
    (length_of_board).times do
      result << rows[first_coordinate][second_coordinate]
      first_coordinate += 1
      second_coordinate -= 1
    end
    result
  end

  def reverse_diagonal_winner
    if reverse_diagonal.uniq.length == 1 &&
       reverse_diagonal.first != ' '
      return reverse_diagonal.first
    end
    nil
  end

  def row_winner
    rows.each do |row|
      return row.first if row.uniq.length == 1 && row.first != ' '
    end
    nil
  end

  def rows
    squares.values.map(&:value).each_slice(3).to_a
  end
end

class Square
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def empty?
    value == ' '
  end

  def mark(marker)
    @value = marker
  end

  def occupied?
    value != ' '
  end
end

class Player
  attr_accessor :marker
end

class Game
  attr_reader :board, :human, :computer, :current_player

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
    @current_player = nil
  end

  def play
    display_welcome_message

    loop do
      human_chooses_marker
      determine_first_player_to_move
      board.draw

      loop do
        current_player_makes_move
        break if board.winner? || board.all_squares_marked?
        alternate_player
        clear_screen_and_draw_board
      end

      display_result
      break unless play_again?
      reset
    end

    display_goodbye_message
  end

  private

  def alternate_player
    if current_player == human
      @current_player = computer
    else
      @current_player = human
    end
  end

  def assign_markers(selected_marker)
    if selected_marker == 'X'
      human.marker = 'X'
      computer.marker = 'O'
    else
      human.marker = 'O'
      computer.marker = 'X'
    end
  end

  def clear
    system 'clear'
  end

  def clear_screen_and_draw_board
    clear
    board.draw
  end

  def current_player_makes_move
    position = nil
    current_player == human ? position = human_move : position = computer_move

    board.mark_square(position, current_player.marker)
  end

  def computer_move
    board.empty_positions.sample
  end

  def determine_first_player_to_move
    @current_player = [human, computer].sample
  end

  def display_goodbye_message
    puts 'Thanks for playing...Goodbye!'
  end

  def display_result
    clear_screen_and_draw_board

    case board.winning_marker
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts "It's a tie!"
    end
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def human_chooses_marker
    selected_marker = nil
    loop do
      puts "Choose a marker ('X', or 'O'):"
      selected_marker = gets.chomp
      break if %w(X O).include?(selected_marker)
      puts "Must be 'X', or 'O'."
    end
    assign_markers(selected_marker)
  end

  def human_move
    position = nil
    loop do
      puts 'Choose a position (1-9):'
      position = gets.chomp.to_i
      break if board.empty_positions.include?(position)
    end
    position
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, please enter 'y' or 'n'."
    end

    answer == 'y'
  end

  def reset
    board.reset
    @current_player = nil
    clear
  end
end

game = Game.new
game.play
