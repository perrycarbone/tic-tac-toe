class Player
  attr_accessor :marker

  def move(board, position, marker)
    board.mark_square(position, marker)
  end
end
