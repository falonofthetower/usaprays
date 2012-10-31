class ItemRotator
  attr_accessor :items, :pointer, :rate, :rotations

  def initialize(items, args={})
    @items = items 
    @pointer   = args[:pointer]   || 0 
    @rotations = args[:rotations] || 0
    @rate      = args[:rate]      || 1
  end

  def selected_items
    items.rotate(pointer_after_rotate)[0...rate]
  end

  def pointer_after_rotate
    reset_new_pointer
    rotations.times do
      increment_new_pointer
    end
    new_pointer
  end

  protected

    attr_accessor :new_pointer

  private 

    def last_index
      items.length - 1
    end

    def reset_new_pointer
      self.new_pointer = pointer
    end

    def increment_new_pointer
      self.new_pointer += rate
      if new_pointer > last_index
        self.new_pointer -= items.length
      end
    end

end
