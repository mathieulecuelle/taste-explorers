class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.string :location
      t.decimal :price_per_person
      t.integer :maximum_guests
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
