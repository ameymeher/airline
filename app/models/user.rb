class User < ApplicationRecord
  has_secure_password
  has_many :reservations
  has_many :baggages
  validates :credit_card_no, length: {is: 19}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :mobile, length: {is: 10}, format: { with: /\A\d+\z/}
end
