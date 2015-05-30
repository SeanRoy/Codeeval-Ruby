File.open(ARGV[0]).each_line do |line|

  line.chomp!

  new_line = ''

  last = line[0]

  (0...line.size).each do |i|
    if line[i] != new_line[-1]
      new_line << line[i]
    end
  end

  puts new_line
end