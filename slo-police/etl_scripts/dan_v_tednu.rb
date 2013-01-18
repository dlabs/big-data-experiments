require "./compiler"
require "csv"

# Število tokenov za kazniva dejanja

@file_in = ARGV.first
if ARGV.first.nil?
  puts "Manjka pot do datoteke!"
end

@uk_list = []
@csv = CSV.open("dan_v_tednu.csv", "wb")
@csv << %w{id,dan}

lr = Compiler::LineReader.new(@file_in) do |line|
  unless @uk_list.include? line.dan_v_tednu
    @uk_list.push line.dan_v_tednu
  end
end

@uk_list.sort!.each_with_index do |interval,index|
  @csv << [index, interval]
end

#NOTE: Popravljeno by hand.
