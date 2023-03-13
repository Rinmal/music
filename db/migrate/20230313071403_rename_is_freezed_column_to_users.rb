class RenameIsFreezedColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :is_freezed, :is_frozen
  end
end
