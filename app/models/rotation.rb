class Rotation < ActiveRecord::Base
  attr_accessor :items, :rate, :date
  attr_accessible :name, :last_rotated_on, :pointer

  before_create :set_defaults

  def self.select(name, items, args={})
    r = find_or_create_by_name(name)
    r.items = items
    r.rate = args[:rate] || 1
    r.date = args[:date] || Date.current
    r.update_and_select
  end

  def update_and_select
    save_rotation_if_required
    selected_items
  end

  private

    def save_rotation_if_required
      unless date == last_rotated_on
        update_attributes(pointer: pointer_after_rotate, last_rotated_on: date)
      end
    end

    def selected_items
      item_rotator.selected_items
    end

    def number_of_days
      rd = RotationDay.new(start_date: last_rotated_on, end_date: date)
      rd.non_boundry_days_between
    end

    def pointer_after_rotate
      item_rotator.pointer_after_rotate
    end

    def item_rotator
      @item_rotator ||= ItemRotator.new(items, 
                                        pointer: pointer,
                                        rate: rate,
                                        rotations: number_of_days)
    end

    def set_defaults
      write_attribute(:pointer, 0) if pointer.nil?
      write_attribute(:last_rotated_on, Date.current) if last_rotated_on.nil?
    end
end
