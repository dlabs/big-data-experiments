#!/usr/bin/env ruby
# encoding: UTF-8

# By Oto Brglez - <oto.brglez@opalab.com>

require "./compiler"

describe Compiler::Line do
  let(:one_line) { File.open('./years/2011/kd.txt',"r:UTF-8", &:readline) }

  describe "line has some splits" do
    subject { one_line }
    it { should_not be_nil }
    it { should match /\$/ }
  end

  describe "parsing line" do
    subject do
      c = Compiler::Line.new(one_line)
      c.parse
      c
    end
    its(:stevilka_kaznivega_dejanja){ should_not eq "" }
    its(:datum_storitve_kaznivega_dejanja){ should_not eq "" }
    its(:ura_storitve_kaznivega_dejanja){ should_not eq ""}
    its(:dan_v_tednu) { should_not eq ""}
    its(:pu_storitve_kd) { should_not eq ""}
  end

end

describe Compiler::LineReader do
  subject do
    @pom = []
    Compiler::LineReader.new('./years/2011/kd_100.txt') do |line|
      @pom << line.stevilka_kaznivega_dejanja
    end
    @pom
  end
  its(:size) { should eq 100 }
end