#!/usr/bin/env bundle exec ruby

require "advent_of_code"
data = AdventOfCode::DataLoader.read("10")

class CPU
  attr_reader :x, :clock, :display

  def initialize
    @x = 1
    @clock = 0
    @display = ""
  end

  def tick
    @display <<
      if (@x - (@clock % 40)).abs <= 1
        "#"
      else
        "."
      end
    @clock += 1
    @display << "\n" if (@clock % 40).zero?
  end

  def run_program(program)
    program.each do |command|
      if command == "noop"
        tick
      else
        2.times { tick }
        add_x_value = command.ints.first
        @x += add_x_value
      end
    end
  end
end

cpu = CPU.new
cpu.run_program(data)
puts cpu.display
