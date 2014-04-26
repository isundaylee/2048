require_relative 'lib/core'

def print_board(core)
  0.upto(core.dimension - 1) do |x|
    0.upto(core.dimension - 1) do |y|
      if core.board[x][y]
        print '% 4d ' % core.board[x][y]
      else
        print '     '
      end
    end
    2.times { puts }
  end
end

core = GameCore.new

commands = {'w' => GameCore::UP, 's' => GameCore::DOWN, 'a' => GameCore::LEFT, 'd' => GameCore::RIGHT}

while true
  print_board(core)

  direction = gets.strip
  result = core.move(commands[direction])

  if result == GameCore::WINNING
    puts 'You won! '
    break
  elsif result == GameCore::LOSING
    puts 'Oh-oh... '
    break
  end
end
