# https://adventofcode.com/2015/day/7/answer

wires = {}

File.read("day-07.in").each_line(chomp: true) do |line|
  expr, wire = line.split(" -> ")
  wires[wire] = expr
end

@wires = wires
@memo = {}

def evaluate(name)
  return name.to_i if name =~ /\A\d+\z/

  @memo[name] ||= case @wires[name]
                  when /\A(\w+)\z/
                    evaluate($1)
                  when /(\w+) AND (\w+)/
                    evaluate($1) & evaluate($2)
                  when /(\w+) OR (\w+)/
                    evaluate($1) | evaluate($2)
                  when /(\w+) RSHIFT (\w+)/
                    evaluate($1) >> evaluate($2)
                  when /(\w+) LSHIFT (\w+)/
                    evaluate($1) << evaluate($2)
                  when /NOT (\w+)/
                    ~evaluate($1) & 0xFFFF
                  end
end

part_1 = evaluate("a")
puts part_1

@wires["b"] = part_1.to_s
@memo = {}

puts evaluate("a") # part 2
