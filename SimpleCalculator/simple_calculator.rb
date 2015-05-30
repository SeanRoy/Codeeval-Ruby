class Stack
  def initialize(arr=nil)
    @store = arr.nil? ? [] : arr
  end

  def pop
    @store.pop
  end

  def dequeue
    @store.pop
  end

  def push(element)
    @store.push(element)
    self
  end

  def enqueue(element)
    @store.unshift(element)
    self
  end

  def size
    @store.size
  end

  def empty?
    @store.size == 0
  end

  def peek
    @store[-1]
  end

  def to_s
    @store.join(',')
  end

  def reverse
    @store.reverse!
  end
end
class SimpleQueue
  def initialize(arr=nil)
    @store = arr.nil? ? [] : arr
  end

  def dequeue
    @store.shift
  end

  def enqueue(element)
    @store.unshift(element)
    self
  end

  def push(element)
    @store.push(element)
    self
  end

  def size
    @store.size
  end

  def peek
    @store[0]
  end

  def empty?
    @store.size == 0
  end

  def reverse
    @store.reverse!
  end
end


class Node
  attr_accessor :value
  attr_accessor :left
  attr_accessor :right
  attr_accessor :parent

  def initialize(val=nil)
    @value = val
    @left = nil
    @right = nil
  end
end
class BinaryTree
  attr_accessor :current_node

  def initialize
    @current_node = @root
  end

  def add_left
    if @current_node.left.nil?
      @current_node.left = Node.new
    end
  end

  def add_right
    if @current_node.right.nil?
      @current_node.right = Node.new
    end
  end
end

class SimpleCalculator
  def initialize(queue)
    @q = queue
    @tree = BinaryTree.new
  end

  def solve(cur)
    op = cur.value

    left = cur.left
    right = cur.right

    unless left.nil? && right.nil?
      case op
        when '+'
          result = solve(cur.left) + solve(cur.right)
        when '-'
          result = solve(cur.left) - solve(cur.right)
        when '/'
          result = solve(cur.left) / solve(cur.right)
        when '*'
          result = solve(cur.left) * solve(cur.right)
        when '^'
          result = solve(cur.left) ** solve(cur.right)
      end
    else
      result = cur.value
    end

    result
  end

  def load()
    stack = Stack.new
    root = Node.new
    current = root

    until @q.empty?
      c = @q.dequeue

      # get a number if one exists
      if /\d/.match c
        num = c
        while /[\d\\.]/.match @q.peek
          c = @q.dequeue
          num = num + c
        end

        current.value = num.to_f

        if current.parent.nil?
          current.parent = Node.new
          current.parent.left = current
        end

        current = current.parent
      end

      case c
        when '('
          current.left = Node.new
          current.left.parent = current
          current = current.left
        when ')'

        when '+','-','*','/','^'
          if current.value.nil?
            current.value = c

            current.right = Node.new
            current.right.parent = current
            current = current.right
          else
            current.parent = Node.new
            current.parent.left = current
            current = current.parent
            current.value = c
          end
      end

    end
    root
  end
end

File.open(ARGV[0]).each_line do |line|
  line.chomp!

  if !line.empty?

    sc = SimpleCalculator.new(SimpleQueue.new(line.split('')))

    root = sc.load
    result = sc.solve(root)

    # if a number is precise, like 34.0, convert it to an integer.
    if result.to_f == result.to_i
      result = result.to_i
    end

    puts result
  end
end

