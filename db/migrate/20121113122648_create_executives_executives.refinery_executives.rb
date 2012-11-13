# This migration comes from refinery_executives (originally 1)
class CreateExecutivesExecutives < ActiveRecord::Migration

  def up
    create_table :refinery_executives do |t|
      t.string :name
      t.integer :photo_id
      t.string :title
      t.string :spouse
      t.string :website
      t.string :webform
      t.string :email
      t.string :twitter
      t.string :facebook
      t.string :state_code
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-executives"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/executives/executives"})
    end

    drop_table :refinery_executives

  end

end
