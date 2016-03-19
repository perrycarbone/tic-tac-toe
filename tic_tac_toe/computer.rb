class Computer < Player

  def initialize
    super
  end

  def move(board)
    position = board.empty_positions.sample
    super(board, position, marker)
  end
end
