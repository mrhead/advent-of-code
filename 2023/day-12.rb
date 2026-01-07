records = File.read("day-12.in").split("\n").map do |l|
  springs, groups = l.split
  [springs, groups.split(",").map(&:to_i)]
end

def solve(springs, groups, cache = {})
  if cache[[springs, groups]]
    return cache[[springs, groups]]
  end

  total = 0

  if springs.empty?
    return groups.empty? ? 1 : 0
  end

  if springs[0] == "." || springs[0] == "?"
    total += solve(springs[1..], groups, cache)
  end

  if group_size = groups.first
    if (springs[0] == "#" || springs[0] == "?") && springs[0...group_size].index(".").nil? && springs[group_size] != "#"
      total += solve("." + springs[group_size+1..], groups[1..], cache)
    end
  end

  cache[[springs, groups]] = total
end

part_1 = 0
part_2 = 0

records.each do |springs, groups|
  part_1 += solve(springs + ".", groups)
  part_2 += solve(([springs] * 5).join("?") + ".", groups * 5)
end

puts part_1, part_2

require "minitest/autorun"

class Test < Minitest::Test
  def test_solve
    assert_equal 1, solve(".......", [])
    assert_equal 1, solve("..?....", [])
    assert_equal 0, solve("......", [1])
    assert_equal 1, solve("..?....", [1])
    assert_equal 0, solve("..?....", [2])
    assert_equal 1, solve(".???...", [3])
    assert_equal 1, solve("??...???.", [2, 3])
    assert_equal 2, solve("??...??.", [2])
  end

  def test_example_1
    assert_equal 1, solve("#.#.###.", [1, 1, 3])
    assert_equal 1, solve("#.#.###.", [1, 1, 3])
    assert_equal 1, solve("???.", [1, 1])
    assert_equal 1, solve("???.###.", [1, 1, 3])
  end

  def test_part_2
    solve("???.###????.###????.###????.###????.###.", [1,1,3,1,1,3,1,1,3,1,1,3,1,1,3])
  end
end
