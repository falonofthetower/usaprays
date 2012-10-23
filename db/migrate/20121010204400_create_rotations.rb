class CreateRotations < ActiveRecord::Migration
  def change
    create_table :rotations do |t|
      t.string :name
      t.integer :pointer
      t.date :last_rotated_on

      t.timestamps
    end
  end
end
