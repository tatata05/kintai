class Notification < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :shift, optional: true
  belongs_to :absence, optional: true

  enum type: { 
    unapplied: 0, 
    application_shift: 1, 
    approval_pending_shift: 2,
    application_absence: 3,
    approval_pending_absence: 4,
    approval_shift: 5,
    rejected_shift: 6,
    approval_absence: 7,
    approval_absence: 8 }
end
