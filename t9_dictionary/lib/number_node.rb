require_relative 'node'

class NumberNode < Node
  attr_accessor :child_number_nodes, :child_string_nodes

  def initialize(value=nil)
    super value
    @child_number_nodes = {}
    @child_string_nodes = []
  end
end