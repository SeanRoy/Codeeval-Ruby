File.open(ARGV[0]).each_line do |line|

  line.chomp!

  if line.size > 55
    line = line[0...40]

    lastIndex = line.rindex(/\s+/)

    if ( !lastIndex.nil? && lastIndex > 1 )
      line = line[0...lastIndex]
    end

    line += "... <Read More>"
  end

  puts line
end