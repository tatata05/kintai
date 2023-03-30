class Shift < ApplicationRecord
  belongs_to :employee
  has_many :notices, dependent: :destroy

  validates :start_time, presence: true
  validates :end_time, presence: true
end
