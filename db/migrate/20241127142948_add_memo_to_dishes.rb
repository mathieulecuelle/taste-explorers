class AddMemoToDishes < ActiveRecord::Migration[7.1]
  def change
    add_column :dishes, :memo, :text
  end
end
