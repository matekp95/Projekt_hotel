class Parking < ApplicationRecord
  belongs_to :reservation

  AVAILABLE_PARKING_SPOTS = 20
end
