File.open(ARGV[0]).each_line do |line|

  line.chomp!

  i = 0

  first = nil
  first_index = 0

  line.each_byte do |c|
    num = c - '0'.ord
    if num >= 0 && num <= 9
      if first.nil?
        first = c.chr
        first_index = i
      else
        line[first_index] = c.chr
        line[i] = first
        first = nil
      end
    end

    i = i + 1
  end

  puts line

end