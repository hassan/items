
require 'pry'
require './tax_calculator.rb'

class PriceCalculator

  def initialize(item)
    @item = item
  end

  def total
    return untaxed_price if (@item[:imported] == false) && (@item[:taxable] == false)
    return taxed_price if (@item[:imported] == false) && (@item[:taxable] == true)
    return imported_price if (@item[:imported] == true) && (@item[:taxable] == false)
    return taxed_and_imported_price if (@item[:imported] == true) && (@item[:taxable] == true)
  end

  def untaxed_price
    @item[:price]
  end

  def taxed_price
    price = @item[:price]
    price.add(TaxCalculator.new.basic(price), 5)
  end

  def imported_price
    price = @item[:price]
    price.add(TaxCalculator.new.import(price), 5)
  end

  def taxed_and_imported_price
    price = @item[:price]
    basic_tax = TaxCalculator.new.basic(price)
    import_tax = TaxCalculator.new.import(price)
    price.add(basic_tax, 5).add(import_tax, 5)
  end

end
