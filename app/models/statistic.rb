class Statistic #< ApplicationRecord
  include ActiveModel::Model

  attr_accessor :valid_from, :valid_to
  #chyba nie potrzebne, ale zobaczymy

  validate :date_correctness
  validates :valid_from, :valid_to, presence: true

  def reservations_taken(room_type = RoomType.pluck(:id))
    Reservation.where('room_type IN (?) AND valid_from <= ? AND valid_to >= ?', room_type, valid_to, valid_from).count
  end

  def people_visited_hotel
    Reservation.where('valid_from <= ? AND valid_to >= ?', valid_to, valid_from).sum(:num_of_user)
  end

  def parkings_taken
    Parking.where('valid_from <= ? AND valid_to >= ?', valid_to, valid_from).count
  end

  def date_correctness
    unless self.errors.any?
      self.errors.add(:valid_from, "can't end after 'valid to'") if valid_from > valid_to
    end
  end
end
