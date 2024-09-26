# Money implementation
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

  def to_s
    "#{currency} #{amount}"
  end
end
