require File.dirname(__FILE__) + '/bits'

class Bitch
  
  # Class methods
  
  def self.template(template_name, &block)
    template_name = symbol_if_string(template_name)
    templates[template_name] = self.new
    yield templates[template_name]
    nil
  end
 
  def self.create(template_name, params = {})
    template_name = symbol_if_string(template_name)
    params.each_pair { | field_name, value | templates[template_name][field_name] = value }
    templates[template_name]
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
    field_name = symbol_if_string(field_name)
    field_names << field_name
    field_values << object.get_bits
  end

  def bring(template_name, params = {})
    name = symbol_if_string(name)
    object = Bitch.create(name, params)
    field_names << template_name 
    field_values << object.get_bits
  end

  def bits(field_name, params = {})
    field_name = symbol_if_string(field_name)
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
    field_name = symbol_if_string(field_name)
    field_values[field_names.index(field_name)]
  end

  def []=(field_name, value)
    field_name = symbol_if_string(field_name)
    field_values[field_names.index(field_name)] = value
  end

  private

  def field_names
    @field_names ||= Array.new
  end

  def field_values
    @field_values ||= Array.new
  end

  def self.templates
    @@templates ||= Hash.new
  end

  # Helpers

  def symbol_if_string(name)
    name.to_sym if name.kind_of? String
  end
end

