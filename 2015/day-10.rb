# https://adventofcode.com/2015/day/10
#
# https://en.wikipedia.org/wiki/Look-and-say_sequence

seed = "3113322113"

def look_and_say(seed)
  count = 1
  next_member = ""

  for i in 0...seed.length
    if seed[i] == seed[i+1] 
      count += 1
      next
    else
      next_member << "#{count}#{seed[i]}"
      count = 1
    end
  end

  next_member
end

value = seed

40.times do
  value = look_and_say(value)
end

puts value.length # part 1

10.times do 
  value = look_and_say(value)
end

puts value.length # part 2
