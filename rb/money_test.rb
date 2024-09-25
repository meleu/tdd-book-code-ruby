require "minitest/autorun"

class MoneyTest < Minitest::Test
  def test_multiplication
    fiver = Dollar.new(5)
    tenner = fiver.times(2)

    assert_equal 10, tenner.amount
  end
end
