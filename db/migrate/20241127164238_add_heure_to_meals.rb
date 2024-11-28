class AddHeureToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :heure, :time
  end
end
