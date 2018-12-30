class RoomType < ApplicationRecord
  MAX_EACH_ROOM_COUNT = 5
  validates :name, presence: true, uniqueness: true
  validates :cost, presence: true, numericality: { greater_than: 0 }
  validates :max_people, presence: true, numericality: { greater_than: 0, less_than: 10 }

  # before_destroy :room_with_reservation?

  # private
  #
  # def room_with_reservation?
  #   errors.add(:room_type, " cannot be deleted. It has reservations.") if Reservation.where(room_type: id).count > 0
  # end

  before_destroy do
    room_with_reservation?
    throw(:abort) if errors.present?
  end

  before_update do
    room_with_reservation?
    throw(:abort) if errors.present?
  end

  def room_with_reservation?
    errors.add(:room_type, " cannot be managed. It has reservations.") if Reservation.where(room_type: id).count > 0
  end
end
