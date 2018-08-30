# frozen_string_literal: true

require './tax_calculator.rb'

class Parser
  Item = Struct.new(:quantity, :name, :price, :imported, :taxable)

  def initialize(arg)
    @arg = arg
  end

  def parse
    return item(@arg) if @arg.class == String
    @arg.map { |string| item(string) }
  end

  def item(string)
    /\A(?<quantity>\d+) (?<name>.+) at (?<price>\d+\.\d+)\Z/ =~ string
    Item.new(quantity.to_i, name, BigDecimal(price), imported?(name), taxable?(name))
  end

  private

  # naive and unreliable buy YOLO
  def taxable?(name)
    raise ArgumentError, "Name is required" if name.empty?
    return false if is_book(name)
    return false if is_medicine(name)
    return false if is_food(name)
    true
  end

  def imported?(name)
    raise ArgumentError, "Name is required" if name.empty?
    /imported/ =~ name ? true : false
  end

  def is_book(name)
    /book/ =~ name ? true : false
  end

  def is_medicine(name)
    /pills/ =~ name ? true : false
  end

  def is_food(name)
    /chocolate/ =~ name ? true : false
  end
end
