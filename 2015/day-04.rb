# https://adventofcode.com/2015/day/4

require "digest"

secret_key = "bgvyzdsv"
p1_done = false
i = 0

loop do
  hash = Digest::MD5.hexdigest(secret_key + i.to_s)

  if hash.start_with?("00000") && !p1_done
    puts i # part 1
    p1_done = true
  end

  if hash.start_with?("000000")
    puts i # part 2
    break
  end

  i += 1
end
