#!/usr/bin/env ruby
# encoding: UTF-8
# By Oto Brglez - <oto.brglez@opalab.com>

module Compiler

  class Line
    attr_accessor :raw_line,
      :stevilka_kaznivega_dejanja,
      :datum_storitve_kaznivega_dejanja,
      :ura_storitve_kaznivega_dejanja

    def initialize raw_line
      @raw_line = raw_line
    end

    def parse
      tokens = @raw_line.split '$'
      @stevilka_kaznivega_dejanja = tokens[0]
      @datum_storitve_kaznivega_dejanja = tokens[1]

      # Convert to number 4
      @ura_storitve_kaznivega_dejanja = tokens[2]

      self
    end
  end

  class LineReader
    attr_accessor :parsed_lines
    def initialize file, &parser_block
      #@parsed_lines = []
      File.open(file,"r:UTF-8").each_line do |line|
        #self.parsed_lines <<
        yield(Compiler::Line.new(line).parse, parser_block)
      end
    end
  end

end

