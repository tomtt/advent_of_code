# frozen_string_literal: true

Encoding.default_external = "UTF-8"

require "advent_of_code/version"
require "advent_of_code/elf_string"
require "advent_of_code/elf_array"
require "zeitwerk"

module AdventOfCode
  class << self
    attr_reader :loader

    def root
      Pathname.new(File.absolute_path(File.join(File.dirname(__FILE__), "..")))
    end

    def setup_loader
      @loader = Zeitwerk::Loader.for_gem
      @loader.enable_reloading
      @loader.eager_load
      # @loader.push_dir(ActiveCore.root.join("non-lib/code_dir"))
      @loader.setup
    end
  end
end

AdventOfCode.setup_loader
