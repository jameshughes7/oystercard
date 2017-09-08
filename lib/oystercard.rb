class Oystercard                                                                              #creating Oystercard class
  attr_reader :balance, :entry_station, :exit_station, :journey_history                       #creating attribute readers to expose instance variables: @balance, @entry_station, @exit_station, @journey_history
  MAXIMUM_BALANCE = 20                                                                        #creating MAXIMUM_BALANCE constant and assigning 20 to it
  CARD_MIN_BALANCE = 1                                                                        #creating CARD_MIN_BALANCE constant and assigning 1 to it
  PENALTY = 6                                                                                 #creating PENALTY constant and assinging 6 to it

  def initialize                                                                              #initialize method which Oystercard calls everytime object is instantiated with .new
    @balance = 0                                                                              #Following instance variables are set u by default for all instances of Oystercard:balance instance variable is set to 0.
    @in_journey = false                                                                       #in_journey instance variable is set to false.
    @journey_history = []                                                                     #journey_history instance variable is set to empty array.
  end

  def top_up(amount)
    raise 'Error: maximum balance of 20 exceeded' if amount + balance > MAXIMUM_BALANCE       #guard clause to raise error if instance of balance + amount passed into argument > MAXIMUM BALANCE
    @balance += amount                                                                        #instance of balance is  positively incremented by amount passed into the argument, so that @balance = @balance + amount
  end

  def in_journey?                                                                             #in journey_method? predicate method created
    !!entry_station                                                                           #retunrns true because ! reuturns false and the 2nd ! returns true
  end

  def touch_in(entry_station)                                                                 #touch_in method created that receives one string argument
    raise 'Cannot touch in: minimum balance not met' if balance < CARD_MIN_BALANCE            #guard clause returns string if the balance instance variable < constant variable CARD_MIN_BALANCE
    @entry_station = entry_station                                                            #instance variable entry station assigned the value of the argument passed in to the method
    if @in_journey                                                                            #if statement condition instance of in_jourey equals true
       deduct PENALTY                                                                         #if above is true, calls the deduct method and passes PENALTY as the argument
    else                                                                                     #if in_journey = false then the following:
       deduct CARD_MIN_BALANCE                                                                #calls the deduct method and passes CARD_MIN_BALANCE as the argument
       @in_journey = true
    end
  end

  def touch_out(exit_station)                                                                 #defined touch_out method which takes 1 string argument
    @exit_station = exit_station
    if @in_journey == false                                                                   #if statement started with instance of in_jourey equals true
       deduct PENALTY                                                                         #if above is true, calls the deduct method and passes PENALTY as the argument
    else                                                                                     #if in_journey = false then the following:
       deduct CARD_MIN_BALANCE                                                                #calls the deduct method and passes CARD_MIN_BALANCE as the argument
    end                                                                                       #@exit_station is assigned the value of the argument passed into the method
    current_journey = { entry_station: entry_station, exit_station: exit_station }            #current_journey local variable defined and assigned the value of hash with key (entry & exit station instance variables) and value pairs (value passed into the touch_in & touch_out methods)
    @journey_history << current_journey                                                       #@in_journey instance variable assigned the local variable current_journey. journey history is now a hash contained within an array
    @in_journey = false                                                                       #in_journey instance variable assigend value false                                                                  #deduct method called and constant CARD_MIN_BALANCE is passed in as an argument
    @entry_station = nil                                                                      #entry station instance variable assigned the value nil. So journey has finished
  end

  private                                                                                     #the following methods are set as private and can only be accessed within the class itself

  def deduct(amount)                                                                          #deduct method defined which taked 1 string argument
    @balance -= amount                                                                        #balance instance variable negatively incremented by amount passed into the argument
  end

 def fare                                                                                     #fare method defined
   PENALTY                                                                                    #returns PENALTY constant
 end

end

# (attr_reader)
# def balance
#   @entry_station
# end
