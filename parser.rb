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
  def imported?(name)
    /imported/ =~ name ? true : false
  end

  def taxable?(name)
    ::TaxCalculator.new().taxable? name
  end
end
