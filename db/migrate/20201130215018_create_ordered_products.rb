class CreateOrderedProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :ordered_products do |t|
      t.references :orders, null: false, foreign_key: true
      t.references :movie
      t.integer :quantity
      t.integer :price_of_item

      t.timestamps
    end
  end
end
