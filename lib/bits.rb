# Bits provides an easy way to store and access sequences of bits, 
# allowing input and output in multiple formats

class Bits

  # +bits+:: The bit field to store
  # +length+:: Length of the bit field - default to calculated length, 0-pad on
  # MSB

  def initialize(bits, length = 0)
    @length = length
    @bits = bit_string_from_input(bits, length)
  end

  def +(bits)
    Bits.new("0b#{@bits}" + bit_string_from_input(bits))
  end

  def bit_string
    @bits
  end

  def hex_string
    @bits.to_i(2).to_s(16)
  end

  def oct_string
    @bits.to_i(2).to_s(8)
  end

  def integer
    @bits.to_i(2)
  end

  def set(bits)
    @bits = bit_string_from_input(bits, @length)
  end
  
  protected

  attr_reader :bits

  private

  def bit_string_from_input(bits, length = 0)
    case bits
    when Integer, Fixnum, Bignum
      "%0#{length}b" % bits
    when String
      "%0#{length}b" % Integer(bits)
    when Bits
      bits.bits
    else
      raise TypeError, "Unsupported data type #{bits.class}"
    end
  end
end
