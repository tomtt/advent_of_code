RSpec.describe String do
  describe "#elf_priority" do
    it "is 1 for 'a'" do
      expect("ax".elf_priority).to eq 1
    end

    it "is 26 for 'z'" do
      expect("zx".elf_priority).to eq 26
    end

    it "is 27 for 'A'" do
      expect("Ax".elf_priority).to eq 27
    end

    it "is 56 for 'Z'" do
      expect("Zx".elf_priority).to eq 52
    end
  end
end
