File.open(ARGV[0]).each_line do |line|
  line.chomp!
  index = line.to_i

  res = 0

  index.to_s(2).split('').each do |i|
    if i == '1'
      res = res + 1
    end
  end

  puts res % 3
end