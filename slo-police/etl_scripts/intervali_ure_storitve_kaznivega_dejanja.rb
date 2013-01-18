require "./compiler"
require "csv"

# Število tokenov za kazniva dejanja

@file_in = ARGV.first
if ARGV.first.nil?
  puts "Manjka pot do datoteke!"
end

@uk_list = []
@csv = CSV.open("intervali_ure_kaznivih_dejanj.csv", "wb")
@csv << %w{id,interval}

lr = Compiler::LineReader.new(@file_in) do |line|
  unless @uk_list.include? line.ura_storitve_kaznivega_dejanja
    @uk_list.push line.ura_storitve_kaznivega_dejanja
  end
end

@uk_list.sort!.each_with_index do |interval,index|
  @csv << [index, interval]
end
