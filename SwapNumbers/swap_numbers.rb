
str = ''
first = nil

File.open(ARGV[0]).each_byte do |byte|

  num = byte - '0'.ord

  number = num >= 0 && num <= 9

  if first.nil? && number
    first = byte.chr
  elsif first && number
    print "#{byte.chr}#{str}#{first}"
    first = nil
    str = nil
  elsif first && !number
    str = "#{str}#{byte.chr}"
  else
    print byte.chr
  end


end