class AddNumberOfUsersOnReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :num_of_user, :integer
  end
end
