class Shift < ApplicationRecord
  belongs_to :employee
  has_many :notifications, dependent: :destroy
  has_one :absence, dependent: :destroy

  validates :start_time, presence: true
  validates :end_time, presence: true

  enum status: { unapproved: 0, approved: 1, rejected: 2 }
end
