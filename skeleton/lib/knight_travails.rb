require_relative '00_tree_node'
require 'byebug'

class KnightPathFinder
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
  end

  def self.valid_moves(pos)
    relative_pos = [[-1,2], [1,2], [2,1], [2,-1]]
    valid_moves = relative_pos
    valid_moves += relative_pos.map { |rel| rel.map {|coord| coord * -1} }

    valid_moves.map! do |rel|
      [rel.first + pos.first, rel.last + pos.last]
    end

    valid_moves.select do |move|
      move.first.between?(0, 8) && move.last.between?(0, 8)
    end
  end

  def new_move_positions(pos)
    possible_moves = self.class.valid_moves(pos)

    new_positions = possible_moves.reject do |move|
      @visited_positions.include?(move)
    end

    @visited_positions += new_positions
    new_positions
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    move_queue = [root]

    until move_queue.empty?
      current_node = move_queue.shift
      new_moves = new_move_positions(current_node.value)

      new_moves.each do |move|
        new_node = PolyTreeNode.new(move)
        current_node.add_child(new_node)
        move_queue << new_node
      end
    end

    root
  end


  def find_path(end_pos)
    root = build_move_tree

    end_node = root.dfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = []
    current_node = end_node

    until current_node.nil?
      path.unshift(current_node.value)
      current_node = current_node.parent
    end

    path
  end

end
