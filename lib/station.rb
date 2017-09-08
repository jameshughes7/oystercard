class Station
  def initialize(name, zone)                    #initialize method that takes two arguments
    @station = { name: name, zone: zone }       #Station instane variable = hash of key(name & zone) and value(name & zone) pairs
  end

  def name
    @station[:name]                             #station instance variable retuning the name value from key passed to it
  end

  def zone
    @station[:zone]                             #station instance variable returning the zone value from the zone key passed to it
  end
end
