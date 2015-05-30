
File.open(ARGV[0]).each_line do |line|
  line.chomp!

  a = line.split(';')
  arr = a[0].split(',')
  group_size = a[1].to_i - 1

  start_index = 0
  end_index = group_size

  while end_index < arr.length
    # reverse order from start to end indices
    i = start_index
    j = end_index

    while i < j
      tmp = arr[i]
      arr[i] = arr[j]
      arr[j] = tmp

      i = i + 1
      j = j - 1
    end

    start_index = 1 + start_index + group_size
    end_index = start_index + group_size
  end

  puts arr.join(',')
end
