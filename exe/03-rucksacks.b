#!/usr/bin/env bundle exec ruby

require "advent_of_code"
puts AdventOfCode::DataLoader
  .read("03")
  .each_slice(3)
  .to_a
  .map { |r| (r[0].chars & r[1].chars & r[2].chars).first.elf_priority }
  .sum
