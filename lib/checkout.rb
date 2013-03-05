class Checkout
  def initialize(basket, promos=[])
    @basket, @promos = basket, promos
  end
  
  def process
    @scanned = []
    @basket.each { |item| self.scan(item) }
    self.total(@scanned, @promos)
  end
  
  def scan(item)
    @scanned << item
  end
  
  def total(scanned, promos)
    @total = discount = 0
    scanned.each { |item| @total += item.price }
    promos.each { |p| discount += p.apply_promo(scanned) }
    puts (@total - discount).round(2)
  end
end

class Item
  attr_reader :code, :name, :price
    
  def initialize(code, name, price)
    @code, @name, @price = code, name, price
  end
end

class PromotionalItem
  def initialize(name, &block)
    @name, @block = name, block
  end
  
  def apply_promo(items)
    @block.call(items)
  end
end





@i1 = Item.new(001, "Lavender heart", 9.25)
@i2 = Item.new(002, "Personalised cufflinks", 45.00)
@i3 = Item.new(002, "Kids T-shirt", 19.95)

@promo1 = PromotionalItem.new('10% off over 60') do |items|
  total = 0
  items.each { |item| total += item.price }
  total > 60 ? total * 0.1 : 0
end

@basket1 = [@i1, @i2, @i2]

co = Checkout.new(@basket1, [@promo1])
co.process()