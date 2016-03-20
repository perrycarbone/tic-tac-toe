class Computer
  attr_accessor :marker

  def move(board)
    position = board.empty_positions.sample
    board.mark_square(position, marker)
  end
end
