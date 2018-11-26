class RenameColumnInRoomTypes < ActiveRecord::Migration[5.1]
  def change
    rename_column :room_types, :type, :name
  end
end
