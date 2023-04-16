class Absence < ApplicationRecord
  belongs_to :shift
  has_many :notifications, dependent: :destroy

  validates :shift_id, uniqueness: true

  enum status: { unapproved: 0, approved: 1, rejected: 2 }
end
