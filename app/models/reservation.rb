class Reservation < ApplicationRecord
  validates :no_of_passengers, presence: true ,numericality: { only_integer: true }
  validates :ticket_class, presence: true, inclusion: { in: %w(first business economy),
                                                             message: "%{value} is not a valid class" }
  validates :amenities, presence: true, inclusion: { in: %w(none wifi meal_preference extra_legroom),
                                                     message: "%{value} is not a valid amenity" }
  validates :cost, presence: true, numericality: true
  has_one :flight
  belongs_to :user
  has_many :baggages , dependent: :delete_all
end
