class ChangeQuestionIdToNullableInDishes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :dishes, :question_id, true
  end
end
