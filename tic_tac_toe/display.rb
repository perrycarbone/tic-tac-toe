class Display
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def clear
    system 'clear'
  end

  def clear_screen_and_draw_board
    clear
    board.draw
  end

  def goodbye_message
    puts 'Thanks for playing...Goodbye!'
  end

  def result(human, computer)
    clear_screen_and_draw_board

    case board.winner
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts "It's a tie!"
    end
  end

  def welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end
end
