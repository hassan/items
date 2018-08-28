# frozen_string_literal: true

require 'test/unit'
require 'json'
require './parser.rb'

class ParserTest < Test::Unit::TestCase

  test 'it parses a non-taxable item' do
    input = '1 book at 12.49'
    assert_equal Parser.new(input).parse.quantity, 1 # [1, 'book', BigDecimal('12.49'), false, false]
    assert_equal Parser.new(input).parse.name, 'book'
    assert_equal Parser.new(input).parse.price, BigDecimal('12.49')
    assert_equal Parser.new(input).parse.taxable, false
    assert_equal Parser.new(input).parse.imported, false
  end

  test 'it parses a taxable item' do
    input = '1 music CD at 14.99'
    assert_equal Parser.new(input).parse.taxable, true
  end

  test 'it recognizes an imported item' do
    input = '1 imported book at 12.49'
    assert_equal Parser.new(input).parse.imported, true
    input = '1 box of imported chocolates at 11.25'
    assert_equal Parser.new(input).parse.imported, true
  end

  test 'it parses multiple items' do
    input = ['1 book at 12.49', '1 music CD at 14.99', '1 chocolate bar at 0.85']
    assert_equal Parser.new(input).parse.size, 3
    assert_equal Parser.new(input).parse.reduce(0) { |acc, i| acc + i.quantity }, 3
    assert_equal Parser.new(input).parse.reduce(0) { |acc, i| acc + i.price }, BigDecimal('28.33')
  end
end
