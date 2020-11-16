class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.date :release_date
      t.integer :rating
      t.text :description
      t.string :director

      t.timestamps
    end
  end
end
