class Checkout
  def initialize(basket)
    @basket = basket
  end
  
  def process
    @scanned = []
    @basket.each { |item| self.scan(item) }
    self.total(@scanned)
  end
  
  def scan(item)
    @scanned << item
    puts item.name
  end
  
  def total(scanned)
    @total = 0
    scanned.each { |item| @total += item.price }
  end
end

class Item
  attr_reader :name, :price
    
  def initialize(code, name, price)
    @code, @name, @price = code, name, price
  end
end





@i1 = Item.new(001, "Lavender heart", 9.25)
@i2 = Item.new(002, "Personalised cufflinks", 45.00)
@i3 = Item.new(002, "Kids T-shirt", 19.95)

@basket1 = [@i1, @i2]

co = Checkout.new(@basket1)