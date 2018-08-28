# frozen_string_literal: true
require 'bigdecimal'

class TaxCalculator

  BASIC_RATE = BigDecimal('0.10')

  def taxable?(name)
    raise ArgumentError, "Name is required" if name.empty?
    return false if is_book(name)
    return false if is_medicine(name)
    return false if is_food(name)
    true
  end

  def basic(price)
    price.mult(BASIC_RATE, 2)
  end
  
  private

  # strictly proof-of-concept
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
