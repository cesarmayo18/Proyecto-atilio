class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer :role
      t.integer :balance
      t.string :name
      t.string :pic_profile
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
