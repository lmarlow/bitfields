require File.dirname(__FILE__) + '/bits'

class BitFields
  
  # Class methods
  
  def self.template(template_name, &block)
    template_name = symbol_if_string(template_name)
    templates[template_name] = self.new
    yield templates[template_name]
    nil
  end
 
  def self.create(template_name, params = {})
    template_name = symbol_if_string(template_name)
    instance = Marshal.load(Marshal.dump(templates[template_name])) # Deep clone
    params.each_pair { | field_name, value | instance[field_name] = value }
    instance
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

  def add(field_name, object)
    field_name = BitFields.symbol_if_string(field_name)
    field_names << field_name
    field_values << object.get_bits
  end

  def bring(template_name, params = {})
    name = BitFields.symbol_if_string(name)
    object = BitFields.create(name, params)
    field_names << template_name 
    field_values << object.get_bits
  end

  def bits(field_name, params = {})
    field_name = BitFields.symbol_if_string(field_name)
    value = params.key?(:value) ? params[:value] : 0
    length = params.key?(:length) ? params[:length] : 0
    field_names << field_name
    field_values << Bits.new(value, length)
  end

  def get_bits
    field_values.inject(nil) do |final, value|
      final ? final + value : value
    end
  end

  def [](field_name)
    field_name = BitFields.symbol_if_string(field_name)
    field_values[field_names.index(field_name)] if field_names.index(field_name)
  end

  def []=(field_name, value)
    self[field_name].set(value) if self[field_name]
  end

  def field_names
    @field_names ||= Array.new
  end

  def field_values
    @field_values ||= Array.new
  end

  private

  def self.templates
    @@templates ||= Hash.new
  end

  # Helpers

  def self.symbol_if_string(name)
    name.kind_of?(String) ? name.to_sym : name
  end
end

