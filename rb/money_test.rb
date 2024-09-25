require 'minitest/autorun'

class Money
  attr_reader :amount, :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def times(multiplier)
    Money.new(amount * multiplier, currency)
  end

  def divide(divisor)
    Money.new(amount.to_f / divisor, currency)
  end

  def ==(other)
    amount == other.amount && currency == other.currency
  end
end

class MoneyTest < Minitest::Test
  def test_multiplication_in_dollars
    five_dollars = Money.new(5, 'USD')
    ten_dollars = Money.new(10, 'USD')
    assert_equal ten_dollars, five_dollars.times(2)
  end

  def test_multiplication_in_euros
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
end
