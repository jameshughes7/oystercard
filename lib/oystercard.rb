class Oystercard

MAXIMUM_BALANCE = 20

attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Error: maximum balance of 20 exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end


=begin (attr_reader)
def balance
  @balance
end
=end
