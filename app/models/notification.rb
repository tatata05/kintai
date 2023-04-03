class Notification < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :shift, optional: true
  belongs_to :absence, optional: true

  enum kind: {
    application: 0,
    approval: 1,
    approval_pending: 2,
    rejected: 3,
    unapplied: 4
  }
end
