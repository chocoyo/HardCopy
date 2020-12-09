class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :order_status
      t.integer :PST
      t.integer :GST
      t.integer :HST
      t.integer :total

      t.timestamps
    end
  end
end
