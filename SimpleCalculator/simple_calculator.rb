
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

class SimpleCalculator
  def initialize
    @operands = Stack.new
    @operators = Stack.new
    @decimalString = SimpleQueue.new
    @minus = false
  end

  def to_number(str)
    if /\./.match(str)
      str.to_f
    else
      str.to_i
    end
  end

  def solve()
    result = 0.0;
    until @operators.empty?
      op = @operators.pop

      operand2 = @operands.pop.to_f
      operand1 = @operands.pop.to_f

      case op
        when '+'
          result = operand1 + operand2
        when '-'
          result = operand1 - operand2
        when '/'
          result = operand1 / operand2
        when '*'
          result = operand1 * operand2
      end

      # if a number is precise, like 34.0, convert it to an integer.
      if result.to_f == result.to_i
        result = result.to_i
      end

      @operands.push(result)
    end

    if @operands.size == 1
      result = @operands.pop
    end

    result
  end

  def numberComplete(q)
    if ! @decimalString.empty?
      str = ''
      until @decimalString.empty?
        str = @decimalString.dequeue.to_s + str
      end

      neg = 1
      if @minus
        neg = -1
        minus = false
      end

      num = to_number(str) * neg

      if q.peek == '^'
        q.dequeue
        num = num ** to_number(q.dequeue)
      end

      @operands.push num
    end
  end
  def load(q)
    until q.empty?
      c = q.dequeue

      if /[\d\.]/.match(c)
        @decimalString.enqueue c
        numberComplete(q) if q.empty? || !/[\d\.]/.match(q.peek)
      else
       case c
         when '-'
           if /\d/.match(q.peek)
             minus = true
           else
             @operators.enqueue c
           end
         when '('
           new_queue = SimpleQueue.new
           until q.peek == ')'
             new_queue.push q.dequeue
           end

           # Get rid of the closing parentheses
           q.dequeue

           sc = SimpleCalculator.new
           sc.load(new_queue)
           @operands.pop
           @operands.push sc.solve
         when '*','/'
           @operators.push c
         when '+','-'
           @operators.enqueue c
       end
      end
    end
  end
end

File.open(ARGV[0]).each_line do |line|
  line.chomp!

  if !line.empty?
    sc = SimpleCalculator.new
    sc.load(SimpleQueue.new(line.split('')))
    puts sc.solve()
  end
end

