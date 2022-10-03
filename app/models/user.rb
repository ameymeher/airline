class User < ApplicationRecord
  has_secure_password
  has_many :reservations, dependent: :destroy
  has_many :baggages, dependent: :destroy
  VALID_CREDIT_CARD_REGEX = /\A[\d][\d-]*[\d]\z/i
  validates :credit_card_no, length: {is: 19}, format: { with: VALID_CREDIT_CARD_REGEX }, allow_nil: true, allow_blank: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :mobile, length: {is: 10}, format: { with: /\A\d+\z/}, allow_nil: true, allow_blank: true
  validates :name, presence: true
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/
  validates_presence_of :password, format: { with: VALID_PASSWORD_REGEX }, :message => "should be minimum 6 characters long with one digit included"
end


