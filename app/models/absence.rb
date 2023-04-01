class Absence < ApplicationRecord
  belongs_to :shift
  has_many :notifications, dependent: :destroy

  enum status: { unapproved: 0, approved: 1, rejected: 2 }
end
