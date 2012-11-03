class ItemRotator
  attr_accessor :items, :rate, :rotations

  def initialize(args={})
    @items     = args[:items]     || []
    @rate      = args[:rate]      || 1
    @rotations = args[:rotations] || 0
  end

  def selected_items
    items.rotate(rotations * rate)[0...rate]
  end
end
