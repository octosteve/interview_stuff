# Create a Stack class
#   Has methods, Push, pop, head


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
    old_head = self.head
    self.head = self.head.next
    old_head.data
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

  it "returns the popped item, when pop is called" do
    stack = Stack.new
    stack.push(5)
    stack.push(6)

    item = stack.pop
    expect(item).to eq(6)
  end
end

# Write an extended stack class that has a function get_largest for returning the largest element in the stack.

# V1 Big O issues. It gets slower as the array grows
class ExtendedStack < Stack
  def get_largest
    largest = 0
    until self.peek == :terminate
      if self.peek > largest
        largest = self.peek
      end
      self.pop
    end
    largest
  end
end

#V2
class ExtendedStack < Stack
  attr_reader :largest_stack
  def initialize
    @largest_stack = Stack.new
  end

  def push(item)
    super
    return largest_stack.push(item) if largest_stack.peek == :terminate

    if item > largest_stack.peek
      largest_stack.push(item)
    end
  end

  def pop
    popped = super
    largest_stack.pop if largest_stack.peek == popped
  end

  def get_largest
    largest_stack.peek
  end
end

describe ExtendedStack do
  it "returns the largest number in the stack" do
    stack = ExtendedStack.new
    stack.push(5)
    stack.push(6)

    expect(stack.get_largest).to eq(6)
  end

  it "responds to popping" do
    stack = ExtendedStack.new
    stack.push(5)
    stack.push(6)
    stack.pop

    expect(stack.get_largest).to eq(5)
  end
end
