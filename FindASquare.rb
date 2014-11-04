
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

    arr.sort_by!{ |p| p.x }

    if ( arr[0].y > arr[1].y )
      tmp = arr[0]
      arr[0] = arr[1]
      arr[1] = tmp
    end

    if ( arr[2].y > arr[3].y )
      tmp = arr[2]
      arr[2] = arr[3]
      arr[3] = tmp
    end

=begin
    vDist1 = arr[0].dist(arr[1])
    vDist2 = arr[2].dist(arr[3])
    hDist1 = arr[0].dist(arr[2])
    hDist2 = arr[2].dist(arr[3])

    if ( ( vDist1 != 0 && vDist2 != 0 && hDist1 != 0 && hDist2 != 0 ) &&
         ( vDist1 == vDist2 && vDist2 == hDist1 && hDist1 == hDist2 ) &&
         (arr[0].x == arr[1].x && arr[2].x == arr[3].x ) &&
         (arr[0].y == arr[2].y && arr[1].y == arr[3].y ) )
      puts 'true'
      next
    end
=end

    arr.each do |p|
      print p.to_s
    end

     if (
         (arr[0] != arr[1] && arr[1] != arr[2] && arr[2] != arr[3] ) &&
         (arr[0].x == arr[1].x && arr[2].x == arr[3].x ) &&
         (arr[0].y == arr[2].y && arr[1].y == arr[3].y ) &&
         (arr[0].dist(arr[1]) == arr[0].dist(arr[2]))
       )
       puts 'true'
       next
     end

    puts false
  end
end