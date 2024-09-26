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
    total = moneys.sum(&:amount)
    Money.new(total, currency)
  end
end
