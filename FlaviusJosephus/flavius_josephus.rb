class FlaviusJosephus

  File.open(ARGV[0]).each_line do |line|
    line.chomp!

    ps = line.split(',')
    size = ps[0].to_i
    nth = ps[1].to_i
    i = -1

    output = Array.new
    j = Array.new(size, false)

    while output.length < size
      x = 0
      while x < nth
        i = (i + 1) % size
        x += 1 if !j[i]
      end

      # record the index
      output << i

      # kill the guy
      j[i] = true
    end

    puts output.join(' ')
  end
end