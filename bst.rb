class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end

  def left?
    !!left
  end

  def right?
    !!right
  end
end

class Bst
  attr_reader :root
  def initialize(root)
    @root = root
  end

  def add_node(node)
    parent, direction = parent_for_orphan(root, node)
    parent.send("#{direction}=", node)
  end

  def parent_for_orphan(root, node)
    if root.value > node.value
      return [root, :left] unless root.left?
      parent_for_orphan(root.left, node)
    else
      return [root, :right] unless root.right?
      parent_for_orphan(root.right, node)
    end
  end

  def find(value)
    lookup_by_value(root, value)
  end

  def min
    current = root
    while current.left?
      current = current.left
    end
    current.value
  end

  def max
    current = root
    while current.right?
      current = current.right
    end
    current.value
  end

  def lookup_by_value(root, value)
    return unless root
    return root if root.value == value

    if root.value > value
      lookup_by_value(root.left, value)
    else
      lookup_by_value(root.right, value)
    end
  end
end

require 'rspec'
describe Bst do
  let(:bst) do
    # root
    bst = Bst.new(Node.new(5))
    # right
    bst.add_node(Node.new(6))
    # right right
    bst.add_node(Node.new(10))
    # right right right
    bst.add_node(Node.new(11))
    # right right left
    bst.add_node(Node.new(8))
    # left
    bst.add_node(Node.new(4))
    bst.add_node(Node.new(3))
    bst
  end

  describe "inserting nodes" do
    it "is initialized with a node" do
      expect(bst.root.value).to eq(5)
    end

    it "adds nodes with higher values to a tree's right branch" do
      expect(bst.root.right.value).to eq(6)
    end

    it "adds nodes with lower values to a tree's left branch" do
      expect(bst.root.left.value).to eq(4)
    end

    it "travels down tree for the next available spot" do
      left_child = bst.root.left
      expect(left_child.left.value).to eq(3)
    end

    it "sets deeply nested values" do
      right_child = bst.root.right
      right_right_child = right_child.right
      expect(right_right_child.left.value).to eq(8)
      expect(right_right_child.right.value).to eq(11)
    end
  end
  describe "finding nodes" do
    it "returns the node if in tree" do
      expect(bst.find(10).value).to eq(10)
    end
    it "returns the nil if node not found" do
      expect(bst.find(42)).to be_nil
    end
  end
  it "returns the smallest number" do
    expect(bst.min).to eq(3)
  end

  it "returns the largest number" do
    expect(bst.max).to eq(11)
  end
end
