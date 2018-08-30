# frozen_string_literal: true

require 'test/unit'
require './tax_calculator.rb'

class TaxCalculatorTest < Test::Unit::TestCase

  test 'it calculates basic tax' do
    price = BigDecimal('14.99')
    assert_equal TaxCalculator.new().basic(price), BigDecimal('1.50')
  end

  test 'it calculates import tax' do
    price = BigDecimal('14.99')
    assert_equal TaxCalculator.new().import(price), BigDecimal('0.75')
  end
end
