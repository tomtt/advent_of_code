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

  describe "#ints" do
    it "is empty array for a string with no digits" do
      expect("".ints).to eq []
    end

    it "is an item with single number when there is one number" do
      expect("1234".ints).to eq [1234]
    end

    it "is an item with each number when there is are multiple numbers" do
      expect("12 34".ints).to eq [12, 34]
    end

    it "works with negative numbers" do
      expect("-43 -21".ints).to eq [-43, -21]
    end

    it "treats any non number character as a separator" do
      expect(" [1](2)-3- 4abcde5\n6!@#$%^&*{7.8}".ints).to eq [1, 2, -3, 4, 5, 6, 7, 8]
    end

    it "does not treat a lone dash as a number" do
      expect(" - ".ints).to eq []
    end

    it "treats any dash in front of a number as a negative sign" do
      expect("1 --2-3-4".ints).to eq [1, -2, -3, -4]
    end
  end

  describe "#char_columns" do
    it "returns the right single offset" do
      expect("abcdef".char_columns(offset: 1, step: 1, number: 1)).to eq ["b"]
      expect("abcdef".char_columns(offset: 3, step: 1, number: 1)).to eq ["d"]
    end

    it "returns the right number of characters" do
      expect("abcdef".char_columns(offset: 1, step: 1, number: 3)).to eq ["b", "c", "d"]
      expect("abcdef".char_columns(offset: 3, step: 1, number: 3)).to eq ["d", "e", "f"]
    end

    it "makes the right steps" do
      expect("abcdefghi".char_columns(offset: 1, step: 2, number: 3)).to eq ["b", "d", "f"]
      expect("abcdefghi".char_columns(offset: 3, step: 2, number: 3)).to eq ["d", "f", "h"]
    end

    it "puts nil where no character was present" do
      expect("abcde".char_columns(offset: 2, step: 2, number: 3)).to eq ["c", "e", nil]
    end

    it "can provide multi char columns" do
      result = "abcdefgh".char_columns(offset: 1, step: 3, number: 3, width: 2)
      expect(result).to eq ["bc", "ef", "h"]
    end
  end
end
