# Monster class
class Monster
  attr_accessor :threat_level
  def initialize(threat_level)
    @threat_level = threat_level
  end

  # getters and setters for instance variables
  attr_accessor :threat_level, :habitat

  # class variable for count
    @@count = 0

  # class instance variable for class description
    @class_description = "Ugly Monster!"

  # class method getter for @@count class variable
  def self.count_class
    @@count
  end

  # class method getter for @class_description class instance variable
  def self.class_description
    @class_description
  end

  # initial behavior
  def initialize(threat_level= :high)
    @threat_level = threat_level
    puts "rawr"
    @@count = @@count + 1
  end

  # habitat? instance method
  def habitat?(monster_habitat)
    @habitat == monster_habitat
  end

  # get_dangerous instance method
  def get_dangerous
    # ruby version of a switch statement is case
    case @threat_level
      when :low
        @threat_level = :medium
      when :medium
        @threat_level = :high
      when :high
        @threat_level = :midnight
      when :midnight
        :midnight
    end
  end

  # fight class method
  def fight_class
    nil
  end
end


# dog = Monster.new

# Zombie class
class Zombie < Monster

  def initialize
    puts "is a zombie"
  end

  # zombie version of class_description
  @class_description = "The Walking Dead"

  # initial behavior and values
  def initialize(threat_level= :medium)
    super(threat_level)
    @habitat = "The Alexandria Community"
  end
end
# Werewolf class
class Werewolf < Monster

  # werewolf version of class_description
  @class_description = "Man Wolf"

  # initial behavior and values
  def initialize(threat_level= :low)
    super(threat_level)
    @habitat = "Mountains"
  end

  # update_threat_level instance method
  def update_threat_level
    nil
  end
end
# Flying module
def Flying_module
  nil
end
  #fly method

# Vampire class
class Vampire < Monster

  # vampire class description
  @class_description = "Blood Sucker"

  # Flying module included
end
