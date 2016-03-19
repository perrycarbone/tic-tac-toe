class WinChecker
  attr_reader :squares

  def initialize(squares)
    @squares = squares
  end

  def run
    return row_winner if row_winner
    return column_winner if column_winner
    return forward_diagonal_winner if forward_diagonal_winner
    return reverse_diagonal_winner if reverse_diagonal_winner
    nil
  end

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
    (length_of_board).times do
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
