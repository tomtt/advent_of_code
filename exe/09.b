#!/usr/bin/env bundle exec ruby

require "advent_of_code"
data = AdventOfCode::DataLoader.read("09")

class Position
  attr_reader :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def eql?(other)
    @x == other.x && @y == other.y
  end

  def hash
    [@x, @y].hash
  end

  def move(dir)
    case dir
    when "U"
      Position.new(@x, @y - 1)
    when "R"
      Position.new(@x + 1, @y)
    when "D"
      Position.new(@x, @y + 1)
    when "L"
      Position.new(@x - 1, @y)
    else
      raise "Huh? #{dir}"
    end
  end

  def distances(position)
    [(@x - position.x).abs, (@y - position.y).abs]
  end

  def drag_to(position)
    return self if distances(position).max <= 1
    new_x = @x + (position.x <=> @x)
    new_y = @y + (position.y <=> @y)
    Position.new(new_x, new_y)
  end

  def to_s
    "(#{x}, #{y})"
  end
end

class RopeMover
  def initialize
    @rope = Array.new(10, Position.new)
    @tail_locations = Set.new
    @tail_locations << @rope.first
  end

  def tail_position_count
    @tail_locations.size
  end

  def move(dir)
    @rope[0] = @rope[0].move(dir)
    (@rope.size - 1).times do |i|
      @rope[i + 1] = @rope[i + 1].drag_to(@rope[i])
    end

    @tail_locations << @rope.last
  end

end

rope_mover = RopeMover.new

moves = data.map do |d|
  dir, count = d.split
  [dir] * count.to_i
end.flatten

moves.each { |m| rope_mover.move(m) }
puts rope_mover.tail_position_count
