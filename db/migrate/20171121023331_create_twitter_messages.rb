class CreateTwitterMessages < ActiveRecord::Migration
  def change
    create_table :twitter_messages do |t|
      t.string :message

      t.timestamps
    end
  end
end
