class Square
    attr_accessor :x, :y, :parent, :children
    def initialize(x, y, parent=nil)
        @x = x
        @y = y
        @children = []
        @parent = parent
    end
end

def create_children(board)
    potentials = []
    potentials.push(
        [board.x + 2, board.y + 1],
        [board.x + 2, board.y - 1],
        [board.x + 1, board.y + 2],
        [board.x + 1, board.y - 2],
        [board.x - 2, board.y + 1],
        [board.x - 2, board.y - 1],
        [board.x - 1, board.y + 2],
        [board.x - 1, board.y - 2],
    )
    valid_children = potentials.select do |space|
        space[0].between?(0, 8) && space[1].between?(0, 8)

    end

    valid_children = valid_children.map do |space|
        Square.new(space[0], space[1], board)
    end

    @children = valid_children
end

def bfs(search_value, children)
    queue = children
    loop do
        current = queue.shift
        if [current.x, current.y] == search_value
            display_path(current)
            break
        else
            create_children(current).each { |child| queue << child }
        end
    end
end

def knight_moves(first_square, final_square)
    first_children = Square.new(first_square[0], first_square[1])
    create_children(first_children)
    bfs(final_square, @children)
end

def display_path(current)
    parent = current.parent
    array = []
    while !parent.nil?
        array << [parent.x, parent.y]
        parent = parent.parent
    end
    array.reverse!
    array << [current.x, current.y]
    puts "Your path is: "
    array.each { |i| p i }
end

knight_moves([3, 3], [4, 3])