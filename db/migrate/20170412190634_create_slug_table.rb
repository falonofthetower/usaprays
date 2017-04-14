class CreateSlugTable < ActiveRecord::Migration
  def change
    create_table :slugs do |t|
      t.string :path, index: true
      t.string :know_who_id, index: true

      t.timestamps
    end
  end
end
