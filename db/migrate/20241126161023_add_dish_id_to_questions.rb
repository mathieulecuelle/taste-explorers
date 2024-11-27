class AddDishIdToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_reference :questions, :dish, null: false, foreign_key: true
  end
end
