class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :buyer
      t.string :item_name
      t.integer :zipcode
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :banchi
      t.string :tatemono_name
      t.string :room_num
      t.string :tel
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
