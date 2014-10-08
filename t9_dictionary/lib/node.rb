require_relative 'node'

class Node
  attr_accessor :value

  def initialize(value=nil)
    @value = value
  end
end
