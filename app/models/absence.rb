class Absence < ApplicationRecord
  belongs_to :shift
  has_many :notices, dependent: :destroy
end
