require 'minitest/autorun'

require_relative 'money'
require_relative 'portfolio'

# Testing the Money class
class MoneyTest < Minitest::Test
  def test_multiplication
    ten_euros = Money.new(10, 'EUR')
    twenty_euros = Money.new(20, 'EUR')
    assert_equal twenty_euros, ten_euros.times(2)
  end

  def test_division
    original_money = Money.new(4002, 'KRW')
    actual_money_after_division = original_money.divide(4)
    expected_money_after_division = Money.new(1000.5, 'KRW')
    assert_equal expected_money_after_division, actual_money_after_division
  end

  def test_addition
    five_dollars = Money.new(5, 'USD')
    ten_dollars = Money.new(10, 'USD')
    fifteen_dollars = Money.new(15, 'USD')
    portfolio = Portfolio.new
    portfolio.add(five_dollars, ten_dollars)
    assert_equal fifteen_dollars, portfolio.evaluate('USD')
  end

  def test_addition_of_dollars_and_euros
    five_dollars = Money.new(5, 'USD')
    ten_euros = Money.new(10, 'EUR')
    portfolio = Portfolio.new
    portfolio.add(five_dollars, ten_euros)
    expected_value = Money.new(17, 'USD')
    actual_value = portfolio.evaluate('USD')
    assert_equal(
      expected_value, actual_value, "#{expected_value} != #{actual_value}"
    )
  end
end
