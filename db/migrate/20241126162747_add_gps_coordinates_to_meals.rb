class AddGpsCoordinatesToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :gps_longitude, :decimal
    add_column :meals, :gps_latitude, :decimal
  end
end
