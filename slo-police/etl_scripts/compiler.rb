#!/usr/bin/env ruby
# encoding: UTF-8
# By Oto Brglez - <oto.brglez@opalab.com>

module Compiler

  class Line
    attr_accessor :raw_line,
      :stevilka_kaznivega_dejanja,
      :datum_storitve_kaznivega_dejanja,
      :ura_storitve_kaznivega_dejanja,
      :dan_v_tednu,
      :pu_storitve_kd,
      :povratnik,
      :vrsta_kriminalitete_gs,
      :ue_kd,
      :ovadba_a_por,
      :leto_zakljucnega_dokumenta

    def initialize raw_line
      @raw_line = raw_line
    end

    def parse
      @raw_line.gsub! /¬/, "Č" # WTF?!

      tokens = @raw_line.split '$'
      size = tokens.size

      @stevilka_kaznivega_dejanja = tokens[0].strip
      @datum_storitve_kaznivega_dejanja = tokens[1].strip
      @ura_storitve_kaznivega_dejanja = tokens[2].strip
      @dan_v_tednu = tokens[3].strip
      @pu_storitve_kd = tokens[4].strip # glej postaje.csv

      @vrsta_kriminalitete_gs = tokens[7].strip

      @ue_kd = tokens[size-4].strip

      @leto_zakljucnega_dokumenta = tokens[size-2].strip
      @ovadba_a_por = tokens.last.strip

      @povratnik = tokens[10].strip

      self
    end

    def parse_to_objs
      #TODO
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

