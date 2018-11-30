class Parking < ApplicationRecord
  belongs_to :reservation

  AVAILABLE_PARKING_SPOTS = 1
  # validate :reservation_presence
  validate :parking_params

  private

  def parking_params
    if reservation.present?
      if reservation.valid_from != valid_from || reservation.valid_to != valid_to
        self.errors.add(:base, "Dates are not correct")
      end
    end
  end
  #
  # def reservation_presence
  #   if reservation.blank?
  #     self.errors.add(:base, "There is no such reservation")
  #   end
  # end
end
