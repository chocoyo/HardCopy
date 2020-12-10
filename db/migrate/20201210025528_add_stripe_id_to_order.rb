class AddStripeIdToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :StripeID, :string
  end
end
