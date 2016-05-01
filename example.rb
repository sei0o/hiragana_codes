require_relative './lib/hiragana_codes'

puts HiraganaCodes.coordinate_to_code 90 - ARGV[0].to_f, 180 + ARGV[1].to_f, ARGV[2].to_i
