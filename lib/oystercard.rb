class Oystercard
  attr_reader :balance
MAXIMUM_BALANCE = 20

attr_reader :balance

def initialize
  @balance = 0
  @in_journey = false
end

  def top_up(amount)
    fail "Error: maximum balance of 20 exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    @in_journey = false
  end

  def touch_in
    fail "Insufficient balance to touch in" if balance < 1
    @in_journey = true
  end

end

#  def touch_in
#    fail 'Cannot touch in: minimum balance not met' if balance < CARD_MIN_BALANCE
#    @in_journey = true
#  end


=begin (attr_reader)
def balance
  @balance
end
=end
