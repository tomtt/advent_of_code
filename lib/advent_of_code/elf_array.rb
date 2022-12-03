module AdventOfCode
  module ElfArray
    def elf_shared_item
      c1, c2 = each_slice((size / 2.0).round).to_a
      (c1 & c2).first
    end
  end
end

class Array
  include AdventOfCode::ElfArray
end
