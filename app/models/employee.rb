class Employee < ApplicationRecord
  has_many :shifts, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    VALID_PHONE_NUMBER_REGEX = /\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }, uniqueness: true
  validates :emergency_phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }, uniqueness: true
end
