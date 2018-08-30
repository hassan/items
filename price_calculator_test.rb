require 'test/unit'
require './price_calculator.rb'
require './parser.rb'

class PriceCalculatorTest < Test::Unit::TestCase

  test 'it calculates a total with no tax or import duty' do
    input = '1 book at 10.00'
    item = Parser.new(input).parse
    assert_equal PriceCalculator.new(item).total, BigDecimal('10.00')
  end

  test 'it calculates a total with tax but no import duty' do
    input = '1 thing at 10.00'
    item = Parser.new(input).parse
    assert_equal PriceCalculator.new(item).total, BigDecimal('11.00')
  end

  test 'it calculates a total with no tax but import duty' do
    input = '1 imported book at 10.00'
    item = Parser.new(input).parse
    assert_equal PriceCalculator.new(item).total, BigDecimal('10.50')
  end

  test 'it calculates a total with tax and import duty' do
    input = '1 imported thing at 10.00'
    item = Parser.new(input).parse
    assert_equal PriceCalculator.new(item).total, BigDecimal('11.50')
  end

end
