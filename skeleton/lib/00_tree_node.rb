class PolyTreeNode
  attr_accessor :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    node.children << self unless node.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Not a child" unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value

    return nil if @children.empty?

    @children.each do |child|
      found = child.dfs(target_value)
      return found unless found.nil?
    end

    nil
  end

  def bfs(target_value)
    node_queue = [self]

    until node_queue.empty?
      node = node_queue.shift
      return node if node.value == target_value

      node.children.each do |child|
        # return child if child.value == target_value
        node_queue << child
      end
    end

    nil
  end

end
