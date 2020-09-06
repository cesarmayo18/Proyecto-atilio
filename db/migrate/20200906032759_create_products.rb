class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :description
      t.string :name
      t.integer :price
      t.integer :rating
      t.integer :category
      t.string :products_pic
      t.references :profile, foreign_key: true
      t.timestamps
    end
  end
end
