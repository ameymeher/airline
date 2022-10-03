class Flight < ApplicationRecord
  has_many :reservations, dependent: :delete_all
  # validates_uniqueness_of :destination_city, :scope => :source_city
  validates :source_city, presence: true
  validates :destination_city, presence: true
  validates :manufacturer, presence: true
  validates :capacity, presence: true
  validates :cost, presence: true
  validates :name, presence: true
  validates :ticket_class, presence: true



end
