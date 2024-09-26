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
    failures = []
    total = moneys.sum do |money|
      converted_amount = convert(money, currency)
      if converted_amount.nil?
        failures << "#{money.currency}->#{currency}"
        0
      else
        converted_amount
      end
    end
    raise StandardError, "Missing exchange rate(s):[#{failures.join(',')}]" unless failures.empty?

    Money.new(total, currency)
  end

  def convert(money, currency)
    exchange_rates = {
      'EUR->USD' => 1.2,
      'USD->KRW' => 1100
    }
    return money.amount if money.currency == currency

    key = "#{money.currency}->#{currency}"
    rate = exchange_rates[key]
    return nil if rate.nil?

    money.amount * rate
  end
end
