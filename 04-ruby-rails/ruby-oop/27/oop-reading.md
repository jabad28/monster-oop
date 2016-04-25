# Introduction to Classes

### Object vs. Class

An object represents an abstract thing, usually with some properties (attributes) and some sort of behavior (methods). A class, in turn, can create many objects with the same set of properties (attributes) and behaviors (methods).

### Define and Instantiate a Class

Class definitions require three basic components: the reserved word `class`, a name of the class, and the reserved word `end`. By convention, the class name begins with a capital letter.

```ruby
class Car
end
```

To create instances of our class, we will create a variable and assign it the return value of the `Car` class's `Car.new` method.

```ruby
car = Car.new
```

### Instance methods and instance variables

We are able to create instances of a `Car`, but our class is *very* simple and our instances currently don't give us much. We'd like to add properties and behaviors (attributes and methods) for our car instances. We'll start by looking at **instance methods** and **instance variables**. An instance method represents a function that is accessible on every instance of a class. To create an instance method, we just create a regular method inside our class definition. Here's the syntax:

```ruby
class Car
  def drive
    puts "You're going places!"
  end
end
```

Now every car we create will have a "drive" behavior.

```ruby
car.drive
```

Let's give each instance of `Car` a color using instance variables.

An instance variable -- which begins with the `@` symbol -- has the capability of storing data for each instance of a class.

JavaScript lets us access variables inside objects with syntax like `obj.var` or `obj["var"]`. In Ruby, we'll create getter and setter methods by hand instead of accessing instance variables directly. In order to set instance variables we need setter methods for each instance variable.  And in order to access (get) instance variables we will need a getter method for each instance variable (that we want to expose).  We can then use the getters and setters via dot notation.  Let's look at an example.

```ruby
class Car
  # setter method: allows you to SET the color
  def color=(color)  
    @color = color
  end

  # getter method: allows you to GET the color
  def color
    @color
  end
end

car_one = Car.new
car_one.color = "green" # sets @color using the setter method
car_one.color           # gets @color using the getter method

car_two = Car.new
car_two.color = "black"
car_two.color

car_three = Car.new
car_three.color
```



Every time an instance of `Car` is assigned a color, it will have its *own* instance variable named `@color`.

### method: `initialize`

In Ruby there's a built-in method named `initialize` that is invoked every time a class is instantiated.  We can add custom initialization behavior by creating our own `initialize` method.  Let's prove that this is true by adding a method named `initialize`.

```ruby
class Car
  def initialize   # puts "A brand new carrr" when Car.new is called.
    puts "A brand new carrrr!!!!!!"
  end

  def color=(color)
    @color = color
  end

  def color
    @color
  end
end

bmw = Car.new
audi = Car.new
```

If we apply this new knowledge, we can re-write our class definition to give a car a color during instance creation.  

```ruby
class Car
  def initialize(color)
    @color = color
  end

  def color=(color)  
    @color = color
  end

  def color
    @color
  end
end

bmw = Car.new("black")
bmw.color
```

Since we don't *have* to put parentheses around method parameters when we call them, we can change a car's color with familiar syntax:

```ruby
bmw.color=("red")
bmw.color="red with FLAME decals"
# both work to change the car's color
```

**Think Break!**

How does this compare to using JavaScript constructors to create objects?


### `attr_*`

If we add more methods to our class, we will start to notice a lot of repetition:

```ruby
class Car
  def initialize(color, make)
    @color = color
    @make = make
  end

  def make=(make)
    @make = make
  end

  def make
    @make
  end

  def color=(color)
    @color = color
  end

  def color
    @color
  end
end
```

Every getter has a method with a name (`make` and `color`) that is included in the instance variable (`@make` and `@color`). The same is true for setters.  

Ruby provides a syntax to shorten this common pattern: attributes. Attributes allow for the introduction of a different syntax for creating getters and setters. Let's demonstrate this by using Ruby's attributes to create a getter for `make`.


```ruby
class Car
  attr_reader :make  # getter

  def initialize(color, make)
    @color = color
    @make = make
  end

  def make=(make)
    @make = make
  end

  def color=(color)
    @color = color
  end

  def color
    @color
  end
end

bmw = Car.new("red", "bmw")
bmw.make
```

`attr_reader` does the same thing as our former method `make`. We can also use this shorthand syntax to create setters with attributes:

```ruby
class Car
  attr_reader :make  # getter
  attr_writer :make  # setter

  def initialize(color, make)
    @color = color
    @make = make
  end

  def color=(color)
    @color = color
  end

  def color
    @color
  end
end
```

Finally, if we want both a getter (reader) and setter (writer), we can use attr_accessor:

```ruby
class Car
  attr_accessor :make, :color  # getters and setters!

  def initialize(color, make)
    @color = color
    @make = make
  end
end
```




### Class Methods, Class Variables, and Self

Now, there may be moments where we want to get or set properties and behaviors that relate to all instances of a class, as a group. In this case, we need to explore class methods and class variables.

Class methods and class variables are used when data pertains to more than just an instance of a class. Let's imagine that we want to keep count of all cars that were instantiated. We use a class variable, indicated by `@@`.


```ruby
class Car
  attr_accessor :make, :color
  @@count = 0

  def initialize(color, make)
    @color = color
    @make = make
  end
end

```

Adding the class variable was easy enough.  Next, we'll define a getter for it using the keyword `self`. We will explore `self` more during the next several days. For now, know that if you place the word `self` next to a method name, it places the method on the class instead of on an instance of the class.

```ruby
class Car
  attr_accessor :make, :color
  @@count = 0

  def initialize(color, make)
    @color = color
    @make = make
  end

  def self.count
    @@count
  end
end

Car.count
# => 0
```


Our car count isn't actually counting anything yet!  We'll update the count in the `initialize` method so that it increases each time a car is created.

```ruby
class Car
  attr_accessor :make, :color
  @@count = 0

  def initialize(color, make)
    @color = color
    @make = make
    @@count = @@count + 1
  end

  def self.count
    @@count
  end
end

Car.count
# => 0

bmw = Car.new('red', 'bmw')
Car.count
# => 1

audi = Car.new('silver', 'audi')
Car.count
# => 2
```

## Inheritance

Inheritance lets us reuse code from one class as we create subtypes of that class.


### Base Class

We'll use our `Car` class as a base class and make a new `Pickup` class that inherits from `Car`.  Another way to say this is that `Pickup` will be a *subclass* of `Car`.  You can also think of `Car` as `Pickup`'s parent and `Pickup` as `Car`'s child (as in a class inheritance tree).

Notice that this `Car` class is spruced up with two new instance variables: `@speed` and `@model`, and an `accelerate` instance method.

```ruby
class Car
  attr_accessor :make, :model, :color, :speed
  @@count = 0

  def initialize(color, make, model)
    @speed = 0
    @color = color
    @make = make
    @model = model
    @@count = @@count + 1
  end

  def self.count
    @@count
  end

  def accelerate(change)
    @speed += change
  end
end
```


### Subclass

The syntax for inheritance uses `<` in the class definition.  Our pickup trucks will have another property that cars don't: the capacity of their truck beds (`@bed_capacity`). They'll also have a behavior that allows for riding in the back (`ride_in_back`).

```ruby
class Pickup < Car
  attr_accessor :make, :model, :color, :bed_capacity, :speed

  def initialize(color, make, model, bed_capacity)
    @speed = 0
    @color = color
    @make = make
    @bed_capacity = bed_capacity
    @@count = @@count + 1
  end

  def ride_in_back
    puts "Bumpy but breezy!"
  end
end
```

Even though we didn't define the `accelerate` method again, a pickup truck will inherit the behavior from the `Car` class.

```ruby
truck_one = Pickup.new("red", "Chevrolet", "Silverado")
truck_one.speed
# => 0
truck_one.accelerate(40)
truck_one.speed
# => 40
```

Inheritance doesn't go the other way, though -- new cars don't know how to use the `ride_in_back` behavior.

```ruby
cilantro = Car.new("pink", "Kia", "Cilantro")
#=> #<Car:0x007f8c4c1b3520 @speed=0, @color="pink", @make="Kia" @model="Cilantro">
focus.ride_in_back
#=> NoMethodError: undefined method `ride_in_back' for #<Car:0x007f8c4c1b3520 @speed=0, @color="pink", @make="Kia", @model="Cilantro">
```

### Inheritance and Class Variables

Class variables  in Ruby don't interact with inheritance in the way many people would expect.  All subclasses share the same class variable, so changing a class variable within a subclass changes the class variable for the base class and all other subclasses.  This can be good when, for instance, we want to update the total `Car` count whenever a new `Pickup` is created. However, `Pickup`'s `@@count` will always be equal to the total `Car` count.  

This connection can cause lots of issues if it's not intended. For example, a `Vehicle` class might have an `@@num_wheels` variable that stores a "default" number of wheels for a vehicle, say 4.  If `Boat` is later created as a subclass of `Vehicle`, and `Boat`'s `@@num_wheels` is set to 0, then all vehicles will now have their number of wheels set to 0, even `Motorcylces`, `Cars`, `EighteenWheelers` and any other instances of `Vehicle` subclasses.

A better pattern that fits this scenario uses "class instance variables". For the "class instance variable pattern", we create an instance variable for the shared data within the parent class itself (outside of a method definition). Then, we create a class getter method within the parent class to access the class instance variable. Finally, we create a new version of the class instance variable for each subclass.  The data is no longer shared among multiple classes when we use this pattern. Let's see an example.

```ruby
class Vehicle
  @num_wheels = 4
  def self.num_wheels
    @num_wheels
  end
end

class Boat < Vehicle
  @num_wheels = 0
end

class EighteenWheeler < Vehicle
  @num_wheels = 18
end
```



## Modules

Ruby "modules" group together related information (attributes and methods).  They're like simplified classes that can't have instances and don't have inheritance. Rubyists often use them for:
  * "namespacing": encapsulation or bundling of related content, 
  * "mixins": extra methods that can be added into classes without influencing the inheritance tree


#### Namespacing

A commonly used built-in module is `Math`. It encapsulates methods for mathematical concepts like [logarithms](http://ruby-doc.org/core-2.3.0/Math.html#method-c-log) and [square roots](http://ruby-doc.org/core-2.3.0/Math.html#method-c-sqrt) alongside [constants for e and pi](http://ruby-doc.org/core-2.3.0/Math.html#constants-list).  Note how we access the `Math` module's constants with the `::` operator:

```ruby
puts Math::PI
```

The `::` operator has a number of uses related to namespacing. You can think of it as a way to open up a namespace provided by a class or module (like `Math`) and reach inside for a constant (like `PI`).  You'll see this in Rails!

#### Mixins

Check out the first example in Ruby's [documentation for `modules`](http://ruby-doc.org/core-2.3.0/Module.html) to see how you'd `include` one as a mixin.  You can `include` a module in another module or in a class.  One built-in module that's commonly mixed into classes is [`Comparable`](http://ruby-doc.org/core-2.3.0/Comparable.html).

Here's how a simplified `Car` class might look with `Comparable` mixed in to compare cars just based on speed.

```ruby 

class Car
  include Comparable
  attr_accessor :speed

  def initialize
    @speed = 0
  end

  def accelerate(change)
    @speed += change
  end
  
  def <=>(otherCar)
    @speed <=> otherCar.speed
  end
end
```

Note that now two cars with the same speed will be equal (`==`):

```ruby
car_a = Car.new
# => #<Car:0x007fea4a871928 @speed=0>
car_b = Car.new
# => #<Car:0x007fea4a869700 @speed=0>
car_a == car_b
# => true
car_a.accelerate(20)
# => 20
car_a > car_b
# => true
```