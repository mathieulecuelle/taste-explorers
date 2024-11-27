class RenameTypeToPreferenceTypeInPreferences < ActiveRecord::Migration[7.1]
  def change
    rename_column :preferences, :type, :preference_type
  end
end
