require File.dirname(__FILE__) + '/lib/bitch'

# Make a template
Bitch.template :demo do |m|
  m.bits :beginning, :length => 10, :value => 0b1010101010
  m.bits :middle, :length => 5
  m.bits :end, :length => 10, :value => 1
end

# Create an object with that template
message = Bitch.create(:demo)

# 1010101010000000000000001
puts message.bit_string

# Create an object with that template and give it parameters
message = Bitch.create(:demo, :middle => 0b11111)

# 1010101010111110000000001
puts message.bit_string
# 1557c01
puts message.hex_string
# 125276001
puts message.oct_string
# 22379521
puts message.integer

# Compose another message using this object as one of its fields
new_message = Bitch.compose do |m|
  m.bits :before, :length => 1, :value => 1
  m.add :demo__message, message
  m.bits :after, :length => 1, :value => 0
end

# 110101010101111100000000010
puts new_message.bit_string

# Compose another message without creating the original message
newer_message = Bitch.compose do |m|
  m.bits :before, :length => 1, :value => 1
  m.bring :demo, :middle => 0
  m.bits :after, :length => 1, :value => 0
end

# 110101010100000000000000010
puts newer_message.bit_string
