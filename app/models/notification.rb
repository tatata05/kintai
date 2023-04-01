class Notification < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :shift, optional: true
  belongs_to :absence, optional: true
end
