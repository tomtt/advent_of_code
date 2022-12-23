#!/usr/bin/env bundle exec ruby

require "advent_of_code"
class Grid
  attr_reader :values

  def initialize(values)
    @values = values
  end

  def self.from_strings(values)
    new(values.map { |r| r.map(&:to_i) })
  end

  def val_to_s(val)
    return "#" if val == true
    return "." if val == false
    return val
  end

  def to_s
    @values.map { |x| x.map { |y| val_to_s(y) }.join }.join("\n")
  end

  def or(other)
    result = @values.each_with_index.map { |r, i| r.binary_or other.values[i] }
    Grid.new(result.deep_clone)
  end

  def dup
    Grid.new(@values.deep_clone)
  end

  def transpose
    @values = @values.transpose
    self
  end
end

class TreeSpotter
  def initialize(grid)
    @grid = grid.dup
    @vertical = grid.dup.transpose
  end

  def sight_lines(value, x, y)
    right = @grid.values[y][x + 1 .. -1]
    left = @grid.values[y][0...x].reverse
    down = @vertical.values[x][y + 1 .. -1]
    up = @vertical.values[x][0...y].reverse

    [left, right, up, down]
  end

  def count_visible(height, sight_line)
    dist = sight_line.index { |t| t >= height }
    return sight_line.size unless dist
    dist + 1
  end

  def scenic_score(value, x, y)
    sl = sight_lines(value, x, y)
    distances = sl.map { |l| count_visible(value, l) }
    # puts "T:#{value} x:#{x} y:#{y}"
    # puts sl.inspect
    # puts distances.inspect
    distances.mult
  end

  def calculate_scenic_scores
    @ss = Grid.new(@grid.values.each_with_index.map { |r, y| r.each_with_index.map { |c, x| scenic_score(c, x, y) }})
  end

  def max
    @max ||= @ss.values.map(&:max).max
  end

  def display_value(ss)
    value = ((ss.to_f / max) * 10).round
    if value == 0
      " "
    else
      value - 1
    end
  end

  def to_s
    @ss.values.map { |r| r.map { |c| display_value(c) }}.map(&:join).join("\n")
  end
end

grid = Grid.from_strings(File.read(AdventOfCode.root.join("data_files", "08")).to_grid)
tree_spotter = TreeSpotter.new(grid)
tree_spotter.calculate_scenic_scores
puts tree_spotter.to_s
puts tree_spotter.max

