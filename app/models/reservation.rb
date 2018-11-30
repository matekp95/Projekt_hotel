class Reservation < ApplicationRecord
  belongs_to :user
  has_many :parkings, dependent: :destroy
  MAX_PERIOD_TIME = 14
  validates :valid_from, :valid_to, :room_type, presence: true
  validates :token, presence: true, uniqueness: true

  validate :room_presence
  validate :number_of_users
  validate :date_correctness
  validate :period
  validate :room_availability
  validate :parking_availability

  def room_type_name
    RoomType.find(room_type).name if room_type.present?
  end
  #
  # def check_room_availability
  #   if Reservation.where('room_type = ? AND valid_from <= ? AND valid_to >= ?', room_type.to_i, valid_to, valid_from).count >= RoomType::MAX_EACH_ROOM_COUNT
  #     self.errors.add(:base, "Room is not available in this period of time.")
  #   else
  #     self.errors.add(:base, "Room is available in this period of time. You can make reservation!")
  #   end
  # end

  private

  def number_of_users
    unless self.errors.any?
      if RoomType.find(room_type.to_i).max_people < num_of_user
        self.errors.add(:num_of_user, "Too many people")
      end
    end
  end

  def date_correctness
    unless self.errors.any?
      self.errors.add(:valid_from, "can't end after 'valid to'") if valid_from > valid_to
      self.errors.add(:valid_from, "can't be earlier than 6 days from now") if valid_from < Time.zone.now + 6.days
    end
  end

  def room_presence
    if room_type.to_i == 0
      self.errors.add(:room_type, "must be picked!")
    end
  end

  def period
    unless self.errors.any?
      if (valid_to - valid_from).to_i > MAX_PERIOD_TIME
        self.errors.add(:valid_from, "too long period. Max #{MAX_PERIOD_TIME} days")
      elsif valid_to == valid_from
        self.errors.add(:valid_from, "can't equals valid to")
      end
    end
  end

  def room_availability
    if Reservation.where('room_type = ? AND valid_from <= ? AND valid_to >= ?', room_type.to_i, valid_to, valid_from).count >= RoomType::MAX_EACH_ROOM_COUNT
      self.errors.add(:room_type, "is not available in this period of time.")
    end
  end

  def parking_availability
    if Parking.where('valid_from <= ? AND valid_to >= ?', valid_to, valid_from).count >= Parking::AVAILABLE_PARKING_SPOTS
      self.errors.add(:base, "All parkings are taken in this period of time.")
    end
  end
end
