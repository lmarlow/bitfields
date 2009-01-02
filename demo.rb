require File.dirname(__FILE__) + '/lib/bitch'

message = Bitch.compose do |m|
  m.bits :beginning, :length => 10, :value => 0b1010101010
  m.bits :middle, :length => 5
  m.bits :end, :length => 10, :value => 1
end

# 1010101010000000000000001
puts message.get_bits.bit_string

message[:middle] = 31

# 1010101010111110000000001
puts message.get_bits.bit_string
# 1557c01
puts message.get_bits.hex_string
# 125276001
puts message.get_bits.oct_string
# 22379521
puts message.get_bits.integer
