# frozen_string_literal: true
require 'bigdecimal'

class TaxCalculator

  BASIC_RATE = BigDecimal('0.10')
  IMPORT_RATE = BigDecimal('0.05')

  def basic(price)
    price.mult(BASIC_RATE, 2)
  end

  def import(price)
    price.mult(IMPORT_RATE, 2)
  end
end
