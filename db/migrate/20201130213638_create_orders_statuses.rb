class CreateOrdersStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :orders_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
