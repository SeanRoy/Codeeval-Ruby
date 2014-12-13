
@rep = [
  ', yeah!',
  ', this is crazy, I tell ya.',
  ', can U believe this?',
  ', eh?',
  ', aw yea.',
  ', yo.',
  '? No way!',
  '. Awesome!']

@replace = false

def blah(s)
  ret = @replace ? @rep[0] : s
  @rep << @rep.shift if @replace
  @replace = !@replace
  ret
end

File.open(ARGV[0]).each_line do |line|
  puts line.gsub(/[\.\!\?]/){|match| blah(match) }
end
