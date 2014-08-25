# Create a Stack class
#   Has methods, Push, pop, head
# Write an extended stack class that has a function getLargest() for returning the largest element in the stack.


class Stack
  def peek
    head.data
  end

  def push(item)
    item_node = Node.new(item)
    item_node.next = self.head
    self.head = item_node
  end

  def pop
    self.head = self.head.next
  end

  def head
    @head ||= Node.new(:terminate)
  end

  def head=(head)
    @head = head
  end
end

class Node
  attr_reader :data
  attr_accessor :next
  def initialize(data)
    @data = data
  end
end

require 'rspec'

describe Stack do
  it "starts empty" do
    stack = Stack.new
    expect(stack.peek).to eq(:terminate)
  end

  it "can have items pushed to it" do
    stack = Stack.new
    stack.push(5)
    stack.push(6)
    expect(stack.peek).to eq(6)
    expect(stack.head.next.data).to eq(5)
  end

  it "it removes items from the top of the chain" do
    stack = Stack.new
    stack.push(5)
    stack.push(6)

    stack.pop
    expect(stack.peek).to eq(5)
  end
end
