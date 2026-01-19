# https://adventofcode.com/2023/day/17

heat_map = File.read("day-17.in").split("\n").map { _1.chars.map(&:to_i) }

class PriorityQueue
  attr_reader :elements

  def initialize
    @elements = []
  end

  def push(state)
    @elements << state
    bubble_up(@elements.size - 1)
  end

  def pop
    return nil if @elements.empty?

    swap(0, @elements.size - 1)
    min = @elements.pop
    bubble_down(0)
    min[1]
  end

  def empty?
    @elements.empty?
  end

  def size
    @elements.size
  end

  private

  def bubble_up(index)
    parent_index = (index - 1) / 2
    return if index <= 0 || @elements[parent_index][0] <= @elements[index][0]

    swap(index, parent_index)
    bubble_up(parent_index)
  end

  def bubble_down(index)
    child_index = left_child_index(index)
    return if child_index >= @elements.size

    right_index = right_child_index(index)
    if right_index < @elements.size && @elements[right_index][0] < @elements[child_index][0]
      child_index = right_index
    end

    return if @elements[index][0] <= @elements[child_index][0]

    swap(index, child_index)
    bubble_down(child_index)
  end

  def left_child_index(index)
    2 * index + 1
  end

  def right_child_index(index)
    2 * index + 2
  end

  def swap(i, j)
    @elements[i], @elements[j] = @elements[j], @elements[i]
  end
end

DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]] # right, down, left, up

def solve(heat_map, min_straight, max_straight)
  costs = Hash.new(Float::INFINITY)
  queue = PriorityQueue.new

  queue.push([0, [0, 0, 0, 1]])
  queue.push([0, [0, 0, 1, 1]])
  costs[[0, 0, 0, 1]] = 0
  costs[[0, 0, 1, 1]] = 0

  rows = heat_map.size
  cols = heat_map.first.size

  while !queue.empty?
    state = queue.pop

    row, col, dir, run_length = state

    if row == rows - 1 && col == cols - 1 && run_length >= min_straight
      return costs[state]
      break
    end

    DIRECTIONS.each_with_index do |(dr, dc), i|
      next if i != dir && run_length < min_straight
      next if i == dir && run_length == max_straight
      next if i == (dir + 2) % 4 # don't reverse

      next_row = row + dr
      next_col = col + dc

      next if next_row < 0 || next_row >= rows
      next if next_col < 0 || next_col >= cols

      next_heat_loss = heat_map[next_row][next_col]
      next_state = [next_row, next_col, i, i == dir ? run_length + 1 : 1]

      if costs[state] + next_heat_loss < costs[next_state]
        costs[next_state] = costs[state] + next_heat_loss
        queue.push([costs[state] + next_heat_loss, next_state])
      end
    end
  end
end

puts solve(heat_map, 1, 3) # part 1
puts solve(heat_map, 4, 10) # part 2
