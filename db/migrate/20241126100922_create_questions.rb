class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :options_answers
      t.string :answer

      t.timestamps
    end
  end
end
