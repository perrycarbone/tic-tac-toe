class Game
  attr_reader :board, :display, :human, :computer, :current_player

  def initialize
    @board = Board.new
    @display = Display.new(board)
    @human = Human.new
    @computer = Computer.new
    @current_player = nil
  end

  def play
    display.welcome_message

    loop do
      selected_marker = human.choose_marker
      assign_markers(selected_marker)
      determine_first_player
      board.draw

      loop do
        current_player.move(board)
        break if board.winner || board.all_squares_marked?
        alternate_player
        display.clear_screen_and_draw_board
      end

      display.result(human, computer)
      break unless play_again?
      reset
    end

    display.goodbye_message
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

  def determine_first_player
    @current_player = [human, computer].sample
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
    display.clear
  end
end
