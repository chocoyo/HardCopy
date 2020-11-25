class CreateGsts < ActiveRecord::Migration[6.0]
  def change
    create_table :gsts do |t|
      t.integer :rate

      t.timestamps
    end
  end
end
