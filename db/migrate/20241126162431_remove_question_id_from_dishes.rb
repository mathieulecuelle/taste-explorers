class RemoveQuestionIdFromDishes < ActiveRecord::Migration[7.1]
  def change
       remove_foreign_key :dishes, :questions
       remove_column :dishes, :question_id
  end
end
