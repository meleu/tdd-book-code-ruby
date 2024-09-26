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

  def evaluate(bank, currency)
    failures = []
    total = moneys.sum do |money|
      bank.convert(money, currency).amount
    rescue StandardError => e
      failures << e.message
      0
    end
    raise StandardError, "Missing exchange rate(s):[#{failures.join(',')}]" unless failures.empty?

    Money.new(total, currency)
  end
end
