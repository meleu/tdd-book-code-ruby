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
    exchange_rates = {
      'EUR->USD' => 1.2,
      'USD->KRW' => 1100
    }
    if money.currency == currency
      money.amount
    else
      key = "#{money.currency}->#{currency}"
      money.amount * exchange_rates[key]
    end
  end
end
