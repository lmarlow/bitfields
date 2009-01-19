require File.dirname(__FILE__) + '/bits'

class Bitch
  
  # Class methods
  
  def self.template(name, &block)
    templates[name] = self.new
    yield templates[name]
    nil
  end
 
  def self.create(name, params = {})
    params.each_pair { |k,v| templates[name][k] = v }
    templates[name]
  end

  def self.compose(&block)
    composition = self.new
    yield composition
    composition
  end

  # Object methods
  
  def integer; get_bits.integer end
  def bit_string; get_bits.bit_string end
  def hex_string; get_bits.hex_string end
  def oct_string; get_bits.oct_string end

  def add(name, object)
    fields << { name => object.get_bits }
  end

  def bring(name, params = {})
    object = Bitch.create(name, params)
    fields << { name => object.get_bits }
  end

  def bits(name, params = {})
    value = params.key?(:value) ? params[:value] : 0
    length = params.key?(:length) ? params[:length] : 0
    fields << { name => Bits.new(value, length) }
  end

  def get_bits
    fields.inject(nil) do |composed, field|
      bits = field.values.first
      composed ? composed + bits : bits
    end
  end

  def [](name)
    fields.select { |field| field.key?(name) }.first.values.first
  end

  def []=(name, value)
    element_array = fields.select { |field| field.key?(name) }
    element = element_array.first.values.first unless element_array.empty?
    element.set(value) unless element.nil?
  end

  private

  def fields
    @fields ||= Array.new
  end

  def self.templates
    @@templates ||= Hash.new
  end
end

