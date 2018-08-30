require 'test/unit'
require './formatter.rb'
require './parser.rb'
require './tax_calculator.rb'

class FormatterTest < Test::Unit::TestCase

  test 'it formats an item' do
    item = Parser.new('1 imported bottle of perfume at 27.99').parse
    puts item["taxable"]

  end
end
