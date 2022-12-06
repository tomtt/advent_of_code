RSpec.describe AdventOfCode::DataLoader do
  let (:absolute_notes_url) {
    "https://gist.githubusercontent.com/tomtt/2bdafe5e1eeb992bc4bf0ec2e50c6e4e/raw/88105b1716f387614839d0ebab66c71e4d9c94e1/C%2520diatonic%2520notes"
  }

  let (:absolute_strings_url) {
    "https://gist.githubusercontent.com/tomtt/ce823ce60a61bde7cf180afd9ec2cd40/raw/2fbd6f111f5d864e70f5676ee70f0777d283f783/guitar-strings"
  }

  let (:gist_notes_url) {
    "https://gist.github.com/tomtt/2bdafe5e1eeb992bc4bf0ec2e50c6e4e"
  }

  let (:gist_strings_url) {
    "https://gist.github.com/tomtt/ce823ce60a61bde7cf180afd9ec2cd40"
  }

  let(:data_dir) { "spec/fixtures/data_files" }

  it "can load a file in the repo's data_files directory" do
    expect(AdventOfCode::DataLoader.read('guitar_strings', fallback_dir: data_dir)).to eq(['E', 'A', 'D', 'G', 'B', 'e'])
    expect(AdventOfCode::DataLoader.read('taal', fallback_dir: data_dir)).to eq(['aap', 'noot', 'mies'])
  end

  it "can load a file with absolute path" do
    gs_filename = AdventOfCode.root.join(data_dir, 'guitar_strings')
    expect(AdventOfCode::DataLoader.read(gs_filename)).to eq(['E', 'A', 'D', 'G', 'B', 'e'])

    t_filename = AdventOfCode.root.join(data_dir, 'taal')
    expect(AdventOfCode::DataLoader.read(t_filename)).to eq(['aap', 'noot', 'mies'])
  end

  it "can load a file with a relative path" do
    gs_filename = File.join(data_dir, 'guitar_strings')
    expect(AdventOfCode::DataLoader.read(gs_filename)).to eq(['E', 'A', 'D', 'G', 'B', 'e'])

    t_filename = File.join(data_dir, 'taal')
    expect(AdventOfCode::DataLoader.read(t_filename)).to eq(['aap', 'noot', 'mies'])
  end

  it "raises DataNotFoundError is file does not exist" do
    expect(lambda { AdventOfCode::DataLoader.read('/non-existing-file') }).
      to raise_error(AdventOfCode::DataNotFoundError)

    expect(lambda { AdventOfCode::DataLoader.read('anything') }).
      to raise_error(AdventOfCode::DataNotFoundError)
  end

  it "raises DataNotFoundError is file is not a file" do
    expect(lambda { AdventOfCode::DataLoader.read(AdventOfCode.root) }).
      to raise_error(AdventOfCode::DataNotFoundError)
  end

  it "reraises standard errors when opening a file" do
    error = StandardError.new('Some error')
    allow(File).to receive(:read).and_raise(error)
    expect(lambda { AdventOfCode::DataLoader.read('whatever') }).
      to raise_error(error)
  end

  it "can load a file from an absolute url" do
    expect(AdventOfCode::DataLoader.read(absolute_notes_url)[0..2]).to eq ["C", "D", "E"]
    expect(AdventOfCode::DataLoader.read(absolute_strings_url)[0..2]).to eq ["E", "A", "D"]
  end

  it "can load from a gist" do
    expect(AdventOfCode::DataLoader.read(gist_notes_url)[0..2]).to eq ["C", "D", "E"]
    expect(AdventOfCode::DataLoader.read(gist_strings_url)[0..2]).to eq ["E", "A", "D"]
  end

  it "raises DataNotFoundError if url does not exist" do
    url = "https://domainthaterrors.com/404"
    expect(lambda { AdventOfCode::DataLoader.read url }).
      to raise_error(AdventOfCode::DataNotFoundError)

    url = "https://domainthaterrors.com/500"
    expect(lambda { AdventOfCode::DataLoader.read url }).
      to raise_error(AdventOfCode::DataNotFoundError)
  end

  it "raises DataNotFoundError content of url is html" do
    url = "https://domainthaterrors.com/html"
    expect(lambda { AdventOfCode::DataLoader.read url }).
      to raise_error(AdventOfCode::DataNotFoundError)

    url = "https://domainthaterrors.com/html-paragraphs"
    expect(lambda { AdventOfCode::DataLoader.read url }).
      to raise_error(AdventOfCode::DataNotFoundError)
  end

  it "reraises standard errors when opening a url" do
    error = StandardError.new('Some error')
    allow(URI).to receive(:parse).and_raise(error)
    expect(lambda { AdventOfCode::DataLoader.read('https://whatever.com/lines') }).
      to raise_error(error)
  end

  describe "digest_for_source" do
    it "can provide the digest of the content" do
      AdventOfCode::DataLoader.read('taal', fallback_dir: data_dir)
      digest = `sha256sum #{AdventOfCode.root.join(data_dir, 'taal')}|cut -d ' ' -f 1`.strip
      expect(AdventOfCode::DataLoader.digest_for_source('taal', fallback_dir: data_dir)).to eq digest
    end
  end
end
