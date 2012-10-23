class Rotation < ActiveRecord::Base
  attr_accessor :items, :rate
  attr_accessible :items, :rate, :pointer, :name, :last_rotated_on

  before_create :set_defaults

  def self.select(name, items, rate=1)
    r = find_or_create_by_name(name)
    r.items = items
    r.rate = rate
    r.selected_items
  end

  def selected_items
    number_of_days = Date.current - last_rotated_on
    number_of_days.to_i.times do
      rotator.tick!
    end
    rotator.selected_items
  end

  def rotator
    @rotator ||= item_rotator
  end

  def item_rotator
    r = ItemRotator.new
    r.pointer = pointer
    r.rate = rate
    r.items = items
    r
  end

  private
    def set_defaults
      rate = 1 if rate.nil?
      write_attribute(:pointer, 0) if pointer.nil?
      write_attribute(:last_rotated_on, Date.current) if last_rotated_on.nil?
    end
end
