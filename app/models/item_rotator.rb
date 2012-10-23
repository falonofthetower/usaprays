class ItemRotator
  attr_accessor :items, :pointer, :rate

  def selected_items
    @items.rotate(@pointer)[0...@rate]
  end

  def tick!
    @pointer += @rate
    if @pointer > last_index
      @pointer = @pointer - last_index
    end
  end

  private
    def last_index
      @items.length - 1
    end
end
