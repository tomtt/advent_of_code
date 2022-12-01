#!/usr/bin/env bundle exec ruby

require "advent_of_code"
data = AdventOfCode::DataLoader.read("01.a")

class ElfPacker
  attr_reader :elves

  def initialize
    @elves = [[]]
    @current_elf = 0
  end

  def add_entry(entry)
    if entry.empty?
      @elves << []
      @current_elf += 1
      return
    end
    @elves[@current_elf] << entry.to_i
  end

  def max_calories
    @elves.map(&:sum).max
  end

  def top_three
    @elves.map(&:sum).sort[0..3]
  end
end

elf_packer = ElfPacker.new
data.each { |e| elf_packer.add_entry(e) }
top_three = elf_packer.top_three
puts top_three
puts top_three.sum
