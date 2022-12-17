require "json"

module AdventOfCode
  module ElfString
    def elf_priority
      ord > 96 ? ord - 96 : ord - 38
    end

    def json_parse
      return nil if empty?

      JSON.parse(self)
    end

    def ints
      scan(/-?\d+/).map(&:to_i)
    end

    def char_columns(offset:, step:, number:, width: 1)
      chars = []
      index = offset
      number.times do
        chars << self[index, width]
        index += step
      end
      chars
    end

    def to_grid
      rows = split("\n")
      rows.map { |r| r.strip.chars }
    end

    def present?
      !gsub(/\s/, "").empty?
    end
  end
end

class String
  include AdventOfCode::ElfString
end
