class AddInspirationToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :inspiration, :string
  end
end
