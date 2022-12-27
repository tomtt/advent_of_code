module AdventOfCode
  module ElfArray
    def elf_shared_item
      c1, c2 = each_slice((size / 2.0).round).to_a
      (c1 & c2).first
    end

    def deep_clone
      map { |e| e.respond_to?(:deep_clone) ? e.deep_clone : e.dup }
    end

    def map_to_is_first_occurence_of_value
      highest = -Float::INFINITY
      mapping = []
      size.times do |i|
        if self[i] > highest
          mapping[i] = true
          highest = self[i]
        else
          mapping[i] = false
        end
      end
      mapping
    end

    def mult
      inject(1) { |mult, n| mult * n }
    end

    def search(&block)
      each { |r| r.each { |c| return c if block.call(c) } }
    end

    def logical_or(other)
      return self unless other

      each_with_index.map { |e, i| e || other[i] }
    end

    def logical_and(other)
      each_with_index.map { |e, i| e && other[i] }
    end

    def binary_or(other)
      each_with_index.map { |e, i| e | other[i] }
    end

    def binary_and(other)
      each_with_index.map { |e, i| e & other[i] }
    end

    def tr(from, to)
      map { |x| x == from ? to : x }
    end

    def split(element)
      lists = [[]]
      each do |i|
        if i == element
          lists << []
        else
          lists[-1] << i
        end
      end
      lists
    end
  end
end

class Array
  include AdventOfCode::ElfArray
end
