class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.date :valid_from
      t.date :valid_to
      t.string :token
      t.references :user, foreign_key: true
      t.integer :room_type

      t.timestamps
    end
  end
end
