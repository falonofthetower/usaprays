class CreateJusticesJustices < ActiveRecord::Migration

  def up
    create_table :refinery_justices do |t|
      t.string :name
      t.integer :photo_id
      t.string :title
      t.string :spouse
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-justices"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/justices/justices"})
    end

    drop_table :refinery_justices

  end

end
