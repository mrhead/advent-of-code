# https://adventofcode.com/2015/day/11

A = "a".ord
Z = "z".ord

FORBIDDEN = %w(i o l).map(&:ord)

def next_password!(bytes)
  i = bytes.length - 1

  while i >= 0
    if bytes[i] == Z
      bytes[i] = A
      i -= 1
    else
      bytes[i] += 1

      if FORBIDDEN.include?(bytes[i])
        bytes[i] += 1
        bytes.fill(A, i + 1)
      end

      break
    end
  end
end

def has_straight?(bytes)
  i = 0

  while i < bytes.length - 3
    if bytes[i+2] == bytes[i+1] + 1 && bytes[i+1] == bytes[i] + 1
      return true
    end

    i += 1
  end

  false
end

def has_two_non_overlapping_pairs?(string)
  pairs = 0
  i = 0

  while i < string.length-1
    if string[i] == string[i+1]
      pairs += 1
      return true if pairs == 2

      i += 2
    else
      i += 1
    end
  end

  false
end

def valid_password?(password)
  has_straight?(password) && has_two_non_overlapping_pairs?(password)
end

def find_next_valid(bytes)
  loop do
    next_password!(bytes)
    return bytes if valid_password?(bytes)
  end
end

password = "vzbxkghb".bytes

puts find_next_valid(password).pack("C*") # part 1
puts find_next_valid(password).pack("C*") # part 2
