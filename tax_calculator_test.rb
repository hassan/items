# frozen_string_literal: true

require 'test/unit'
require './tax_calculator.rb'

class TaxCalculatorTest < Test::Unit::TestCase

  test 'it knows where basic tax is exempt' do
    %w[book pills chocolates].each do |input|
      assert(!TaxCalculator.new().taxable?(input))
    end
  end

  test 'it knows where basic tax is applied' do
    %w[CD perfume].each do |input|
      assert(TaxCalculator.new().taxable?(input))
    end
  end

  test 'it calculates basic tax' do
    price = BigDecimal('14.99')
    assert_equal TaxCalculator.new().basic(price), BigDecimal('1.50')
  end
end
