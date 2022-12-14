RSpec.describe AdventOfCode do
  it "has a version number" do
    expect(AdventOfCode::VERSION).not_to be nil
  end

  it "knows its root" do
    expect(AdventOfCode.root).to eq Pathname.new(Dir.pwd)
  end

  it "contains the files of itself in its root directory" do
    expect(File).to be_exist File.join(AdventOfCode.root, "lib", "advent_of_code", "version.rb")
  end
end
