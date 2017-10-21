class CreateImportRecord < ActiveRecord::Migration
  def change
    create_table :import_records do |t|
      t.datetime :timestamp
      t.integer :leader_count
      t.string :upload_dates

      t.timestamps
    end
  end
end
