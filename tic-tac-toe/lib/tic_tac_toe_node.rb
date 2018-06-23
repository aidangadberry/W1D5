require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :board, :next_mover_mark
  attr_accessor :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    game_states = []

    @board.rows.each_with_index do |row, rid|
      row.each_with_index do |mark, cid|
        next unless mark.nil?

        pos = [rid, cid]
        new_board = dup_board(pos, @next_mover_mark)
        game_states << TicTacToeNode.new(new_board, swap_mark, pos)
      end
    end

    # @board.rows.each do |row|
    #
    # end

    game_states
  end

  def dup_board(pos, mark)
    new_board = Board.new

    @board.rows.each_with_index { |row, idx| new_board.rows[idx] = row.dup }

    new_board[pos] = mark
    new_board
  end

  def swap_mark
    @next_mover_mark == :x ? :o : :x
  end
end
