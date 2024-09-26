require_relative 'money'

# Portfolio class
class Portfolio
  attr_reader :moneys

  def initialize
    @moneys = []
  end

  def add(*moneys)
    @moneys.concat(moneys)
  end

  def evaluate(currency)
    total = moneys.sum { |money| convert(money, currency) }
    Money.new(total, currency)
  end

  def convert(money, currency)
    eur_to_usd = 1.2
    if money.currency == currency
      money.amount
    else
      money.amount * eur_to_usd
    end
  end
end
