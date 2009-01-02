require File.dirname(__FILE__) + '/bits'

class Bitch
  def self.fields(name, &block)
    formats[name] = self.new
    yield formats[name]
  end
  
  def self.compose(&block)
    composition = self.new
    yield composition
    composition
  end

  def bring(name, params = {})
    format = Bitch.formats[name]
    params.each_pair { |field, value| format[field] = value }
    field_array << { name => format.get_bits }
  end

  def bits(name, params)
    value = params.key?(:value) ? params[:value] : 0
    length = params.key?(:length) ? params[:length] : 0
    field_array << { name => Bits.new(value, length) }
  end

  def get_bits
    field_array.inject(nil) do |fields, field|
      bits = field.values.first
      fields ? fields + bits : bits
    end
  end

  def [](name)
    field_array.select { |field| field.key?(name) }.first.values.first
  end

  def []=(name, value)
    element_array = field_array.select { |field| field.key?(name) }
    element = element_array.first.values.first unless element_array.empty?
    element.set(value) unless element.nil?
  end

  private

  def field_array
    @field_array ||= Array.new
  end

  def self.formats
    @@formats ||= Hash.new
  end
end

