class AddHasParkingToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :has_parking, :boolean
  end
end
