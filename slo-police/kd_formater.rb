require "./compiler"
require "csv"

@file_in, @file_out = ARGV.first, ARGV.last

puts "Input: #{@file_in}, Output: #{@file_out}"

# Helpers
def read_csv_table(csv_file); CSV.read(csv_file,"r:UTF-8",{:headers => !true}); end

# Preloaded tables
@@dan_v_tednu ||= read_csv_table "./policija_kdo/dan_v_tednu.csv"
@@ura_storitve_kaznivega_dejanja ||= read_csv_table "./policija_kdo/intervali_ure_kaznivih_dejanj.csv"
def code_dav_v_tednu(dan)
  begin
    @@dan_v_tednu.select {|row| row.last == dan }.first.first.to_i
  rescue Exception=>e
    puts "ERROR ON: #{dan}"
    exit
  end
end

def code_ura_storitve_kaznivega_dejanja(intv); @@ura_storitve_kaznivega_dejanja.select {|row| row.last == intv }.first.first.to_i; end
def code_povratnik(v); v =~ /D/ ? 1 : 0; end
def code_vrsta_kriminalitete_gs(v); v=="GOSPODARSKA" ? 1 : 0; end
def code_ovadba_a_por(v); v=="OVADBA" ? 1 : 0; end

@csv = CSV.open(@file_out, "wb")

# Procesor
Compiler::LineReader.new(@file_in) do |l|
  out = [
    l.stevilka_kaznivega_dejanja,
    l.datum_storitve_kaznivega_dejanja.split('.').last.to_i,                # leto
    l.datum_storitve_kaznivega_dejanja.split('.').first.to_i,               # mesec
    code_dav_v_tednu(l.dan_v_tednu),                                        # dan
    code_ura_storitve_kaznivega_dejanja(l.ura_storitve_kaznivega_dejanja),

    l.pu_storitve_kd,

    code_povratnik(l.povratnik),

    code_vrsta_kriminalitete_gs(l.vrsta_kriminalitete_gs),

    l.ue_kd, # not kul

    l.leto_zakljucnega_dokumenta.to_i,

    code_ovadba_a_por(l.ovadba_a_por)
  ]

  # puts out.join(",  ") unless ARGV.include? "-s"
  @csv << out
end