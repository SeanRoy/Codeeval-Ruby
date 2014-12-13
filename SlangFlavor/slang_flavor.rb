
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
@output = ''
@rep_index = 0
File.open(ARGV[0]).each_line do |line|
  line.split('').each do |c|
    case c
      when '.', '?', '!'
        if @replace
          @output << @rep[@rep_index]
          @rep_index = @rep_index + 1

          @rep_index = 0 if @rep_index == @rep.length
        else
          @output << c
        end

        @replace = !@replace
      else
        @output << c
    end
  end
end

puts @output