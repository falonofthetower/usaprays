class CreateLeader < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.string :uid
      t.string :legalname
      t.string :firstname
      t.string :lastname
      t.string :prefix
      t.string :photofile
      t.string :statecode
      t.string :district
      t.string :spouse
      t.string :website
      t.string :twitter
      t.string :email
      t.string :facebook
      t.string :webform
      t.string :chamber
      t.string :legtype
      t.string :district
      t.string :residence
      t.string :birthyear
      t.string :birthmonth
      t.string :birthdate

      t.timestamps
    end
  end
end
