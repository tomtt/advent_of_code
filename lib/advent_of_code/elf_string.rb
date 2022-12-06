module AdventOfCode
  module ElfString
    def elf_priority
      ord > 96 ? ord - 96 : ord - 38
    end

    def present?
      !gsub(/\s/, "").empty?
    end
  end
end

class String
  include AdventOfCode::ElfString
end
