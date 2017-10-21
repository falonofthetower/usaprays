class AddImportTimestampToLeaders < ActiveRecord::Migration
  def change
    add_column :leaders, :import_timestamp, :datetime
  end
end
