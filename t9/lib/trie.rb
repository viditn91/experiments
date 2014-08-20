require_relative 'number_node'
require_relative 'string'

class Trie
  attr_accessor :root

  def initialize
    @root = NumberNode.new
  end

  def insert(string)
    last_node = string.chars.inject(root) do |node, char|
      t9_quivalent = char.to_t9
      node.child_number_nodes[t9_quivalent] ||= NumberNode.new(t9_quivalent)
    end
    last_node.child_string_nodes << string
  end

  def find(number)
    last_node = number.to_s.chars.inject(root) do |node, char|
      return false unless node.child_number_nodes[char.to_i]
      node.child_number_nodes[char.to_i]
    end
    last_node.child_string_nodes if last_node
  end
end