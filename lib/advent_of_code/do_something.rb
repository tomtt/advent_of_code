require "pastel"

Encoding.default_external = "UTF-8"

module AdventOfCode
  class DoSomething
    def initialize(options, out: stdout, err: stderr)
      @options = options
      @out = out
      @err = err
    end

    def show
      pastel = Pastel.new
      if pastel.respond_to? @options[:color]
        @out.puts pastel.send(@options[:color], @options[:color])
      else
        @out.puts "🤷‍♂️ #{@options[:color]}"
      end
    end
  end
end
