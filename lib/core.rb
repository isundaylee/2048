class GameCore

  UP    = 0
  RIGHT = 1
  DOWN  = 2
  LEFT  = 3

  VALID   = 0
  INVALID = 1
  WINNING = 2
  LOSING  = 3

  attr_reader :dimension
  attr_reader :board

  def initialize(dimension = 4)
    @dimension = dimension
    @board = Array.new(dimension) { Array.new(dimension) }

    2.times { generate_new_tile }
  end

  def move(direction)
    old_board = (0...dimension).map { |x| (0...dimension).map { |y| @board[x][y] }}

    # Allow me to implement only the LEFT direction by transposing and/or reversing
    if (direction == UP || direction == DOWN)
      @board = @board.transpose
    end

    if (direction == RIGHT || direction == DOWN)
      @board.each { |x| x.reverse! }
    end

    winning = false

    0.upto(dimension - 1) do |x|
      @board[x].compact!

      0.upto(@board[x].size - 2) do |i|
        if @board[x][i] == @board[x][i + 1] && !@board[x][i].nil?
          @board[x][i] *= 2
          @board[x][i + 1] = nil

          winning = true if @board[x][i] == 2048
        end
      end

      @board[x].compact!

      @board[x] << nil while @board[x].size < dimension
    end

    # Transpose and/or reverse back
    if (direction == RIGHT || direction == DOWN)
      @board.each { |x| x.reverse! }
    end

    if (direction == UP || direction == DOWN)
      @board = @board.transpose
    end

    return WINNING if winning

    0.upto(dimension - 1) do |x|
      0.upto(dimension - 1) do |y|
        if old_board[x][y] != @board[x][y]
          generate_new_tile
          return VALID
        end
      end
    end

    return INVALID
  end

  private

    def generate_new_tile
      tile = [2, 4].shuffle.first

      x, y = (0...dimension).to_a.product((0...dimension).to_a).select { |x, y| @board[x][y].nil? }.shuffle.first

      x.nil? ? nil : (@board[x][y] = tile)
    end

    def in_range?(x, y)
      (x >= 0 && x < dimension) && (y >= 0 && y < dimension)
    end

end
