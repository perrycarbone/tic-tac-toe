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
