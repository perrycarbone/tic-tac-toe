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

  def winner
    WinChecker.new(squares).winner
  end
end
