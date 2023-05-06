class Notification < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :shift, optional: true
  belongs_to :absence, optional: true

  scope :by_recently_created, -> { order(created_at: :desc) }

  enum kind: {
    application: 0,
    approval: 1,
    approval_pending: 2,
    rejected: 3,
    unapplied: 4
  }

  def type
    if self.shift_id.present?
      "シフト"
    else
      "欠勤"
    end
  end
end
