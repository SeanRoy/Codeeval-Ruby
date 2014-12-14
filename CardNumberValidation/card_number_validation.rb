class CardNumberValidation
  File.open(ARGV[0]).each_line do |line|
    line.chomp!
    line.gsub!(/\s+/, '')

    nums = line.split('').reverse!
    sum = 0

    nums.each_index do |i|
      num = nums[i].to_i

      if i % 2 == 1
        num = num << 1

        if num > 9
          digits = num.to_s.split('')
          num = digits[0].to_i + digits[1].to_i
        end
      end

      sum += num
    end

    puts sum % 10 == 0 ? 1 : 0
  end
end