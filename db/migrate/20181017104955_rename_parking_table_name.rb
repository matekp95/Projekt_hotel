class RenameParkingTableName < ActiveRecord::Migration[5.1]
  def change
    rename_table :parkings, :parkings
  end
end
