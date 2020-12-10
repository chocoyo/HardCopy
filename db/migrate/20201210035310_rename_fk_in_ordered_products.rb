class RenameFkInOrderedProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :ordered_products, :orders_id, :order_id
  end
end
