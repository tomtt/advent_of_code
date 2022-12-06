module AdventOfCode
  module ElfArray
    def elf_shared_item
      c1, c2 = each_slice((size / 2.0).round).to_a
      (c1 & c2).first
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
