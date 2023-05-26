class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :shifts, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  VALID_PHONE_NUMBER_REGEX = /\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }, uniqueness: true
  validates :emergency_phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }

  def self.guest
    find_or_create_by!(email: 'guest_employee@example.com') do |employee|
      employee.name = "ゲスト従業員"
      employee.phone_number = "080-1234-1234"
      employee.emergency_phone_number = "080-4321-4321"
      employee.password = SecureRandom.urlsafe_base64
    end
  end

end
