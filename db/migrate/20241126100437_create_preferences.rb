class CreatePreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :preferences do |t|
      t.string :type
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
