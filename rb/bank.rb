require_relative 'money'

# Bank class
class Bank
  attr_reader :exchange_rates

  def initialize
    @exchange_rates = {}
  end

  def add_exchange_rate(currency_from, currency_to, rate)
    key = "#{currency_from}->#{currency_to}"
    exchange_rates[key] = rate
  end

  def convert(money, currency)
    return money if money.currency == currency

    key = "#{money.currency}->#{currency}"
    rate = exchange_rates[key]
    raise key if rate.nil?

    Money.new(money.amount * rate, currency)
  end
end
