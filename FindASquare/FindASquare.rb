
class Point
  include Enumerable
  attr_accessor :x
  attr_accessor :y

  def initialize(line)
    line = line.split(',')

    @x = line[0][1...line.count]
    @y = line[1][0...line.count-1]
  end

  def to_s
    print ( "(" + @x + "," + @y + ")" )
  end

  def == (o)
    o.class ==  self.class &&
    o.y == y && o.x == x
  end

  def dist(other)
    ((other.x.to_i - x.to_i)**2 + (other.y.to_i - y.to_i)**2)
  end
end

File.open(ARGV[0]).each_line do |line|
  line.chomp!


  if (!line.empty?)
    pieces = line.split(', ')

    arr = Array.new

    pieces.each do |piece|
      pt = Point.new(piece)
      arr << pt
    end

    # get midpoint
    midX = 0
    midY = 0
    arr.each do |p|
      midX += p.x.to_i
      midY += p.y.to_i
    end

    midX = midX / 4
    midY = midY / 4

    mid = Point.new("(" + midX.to_s + "," + midY.to_s + ")")

    dist = arr[0].dist(mid)

    ret = true

    if dist <= 0
      ret = false
    else
      if arr[0].dist(arr[2]) != arr[1].dist(arr[3])
        ret = false
      end
    end

    puts ret
  end
end