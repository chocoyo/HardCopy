class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.text :name
      t.integer :PST
      t.integer :HST

      t.timestamps
    end
  end
end
