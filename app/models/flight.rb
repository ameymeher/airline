class Flight < ApplicationRecord
  has_many :reservations, dependent: :delete_all
end
