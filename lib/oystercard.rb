class Oystercard
  attr_reader :balance, :entry_station
  MAXIMUM_BALANCE = 20
  CARD_MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise 'Error: maximum balance of 20 exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_out
    @in_journey = false
    deduct CARD_MIN_BALANCE
    @entry_station = nil
  end

  def touch_in(station_name)
    raise 'Cannot touch in: minimum balance not met' if balance < CARD_MIN_BALANCE
    @in_journey = true
    @entry_station = station_name
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end

# (attr_reader)
# def balance
#   @entry_station
# end
