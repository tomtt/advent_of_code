#!/usr/bin/env bundle exec ruby

require "advent_of_code"
data = AdventOfCode::DataLoader.read("04")

def ranges_overlap?(line)
  # Don't you dare think I would EVER do this in production code
  a, b = eval("[#{line.gsub("-", "..")}]").map(&:to_a)
  !(a & b).empty?
end

filtered_data = data.select { |line| ranges_overlap? line }
puts filtered_data.size
