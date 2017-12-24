class KnowwhoFiles < ActiveRecord::Migration
  def change
    create_table :knowwho_files do |t|
      t.string :name

      t.timestamps
    end
  end
end
