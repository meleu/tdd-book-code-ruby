require "minitest/autorun"

class Dollar
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Dollar.new(amount * multiplier)
  end
end

class MoneyTest < Minitest::Test
  def test_multiplication
    fiver = Dollar.new(5)
    tenner = fiver.times(2)

    assert_equal 10, tenner.amount
  end
end
