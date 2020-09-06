class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :cliente, foreign_key: { to_table: 'profiles' }
      t.references :repartidor, foreign_key: { to_table: 'profiles' }, null: true
      t.integer :status
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
