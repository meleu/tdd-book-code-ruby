require 'minitest/autorun'

require_relative 'money'
require_relative 'portfolio'
require_relative 'bank'

# Testing the Money class
class MoneyTest < Minitest::Test
  def setup
    @bank = Bank.new
    @bank.add_exchange_rate('EUR', 'USD', 1.2)
    @bank.add_exchange_rate('USD', 'KRW', 1100)
  end

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
    assert_equal fifteen_dollars, portfolio.evaluate(@bank, 'USD')
  end

  def test_addition_of_dollars_and_euros
    five_dollars = Money.new(5, 'USD')
    ten_euros = Money.new(10, 'EUR')
    portfolio = Portfolio.new
    portfolio.add(five_dollars, ten_euros)
    expected_value = Money.new(17, 'USD')
    actual_value = portfolio.evaluate(@bank, 'USD')
    assert_equal(
      expected_value, actual_value, "#{expected_value} != #{actual_value}"
    )
  end

  def test_addition_of_dollars_and_wons
    one_dollar = Money.new(1, 'USD')
    eleven_hundred_won = Money.new(1100, 'KRW')
    portfolio = Portfolio.new
    portfolio.add(one_dollar, eleven_hundred_won)
    expected_value = Money.new(2200, 'KRW')
    actual_value = portfolio.evaluate(@bank, 'KRW')
    assert_equal(
      expected_value, actual_value, "#{expected_value} != #{actual_value}"
    )
  end

  def test_addition_with_multiple_missing_exchange_rates
    one_dollar = Money.new(1, 'USD')
    one_euro = Money.new(1, 'EUR')
    one_won = Money.new(1, 'KRW')
    portfolio = Portfolio.new
    portfolio.add(one_dollar, one_euro, one_won)
    expected_error_message = 'Missing exchange rate(s):[USD->Kalganid,EUR->Kalganid,KRW->Kalganid]'
    error = assert_raises(StandardError) { portfolio.evaluate(@bank, 'Kalganid') }
    assert_equal expected_error_message, error.message
  end

  def test_conversion_with_different_rates_between_two_currencies
    ten_euros = Money.new(10, 'EUR')
    assert_equal @bank.convert(ten_euros, 'USD'), Money.new(12, 'USD')

    @bank.add_exchange_rate('EUR', 'USD', 1.3)
    assert_equal @bank.convert(ten_euros, 'USD'), Money.new(13, 'USD')
  end

  def test_conversion_with_missing_exchange
    ten_euros = Money.new(10, 'EUR')
    expected_error_message = 'EUR->Kalganid'
    error = assert_raises(StandardError) { @bank.convert(ten_euros, 'Kalganid') }
    assert_equal expected_error_message, error.message
  end
end
