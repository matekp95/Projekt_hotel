class CreateRoomTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :room_types do |t|
      t.string :type
      t.float :cost
      t.integer :max_people

      t.timestamps
    end
  end
end
