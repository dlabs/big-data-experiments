#!/usr/bin/env ruby
# encoding: utf-8

(2000..2011).each do |i|
  fh = File.open("./years/#{i}/KDINTKD.txt", "r") do |f|
    f.read
  end

  puts "#{fh.encoding} - #{fh.valid_encoding?}"
end

