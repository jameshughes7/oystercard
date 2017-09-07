class Oystercard
  attr_reader :balance, :entry_station, :journey_history, :exit_station
  MAXIMUM_BALANCE = 20
  CARD_MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history = []
  end

  def top_up(amount)
    raise 'Error: maximum balance of 20 exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    raise 'Cannot touch in: minimum balance not met' if balance < CARD_MIN_BALANCE
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    current_journey = { entry_station: entry_station, exit_station: exit_station }
    @journey_history << current_journey
    @in_journey = false
    deduct CARD_MIN_BALANCE
    @entry_station = nil
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
