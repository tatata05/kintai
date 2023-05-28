class Shift < ApplicationRecord
  belongs_to :employee
  has_many :notifications, dependent: :destroy
  has_one :absence, dependent: :destroy

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_end_check

  enum status: { unapproved: 0, approved: 1, rejected: 2 }

  # 時間の矛盾を防ぐ
  def start_end_check
    errors.add("end_time", "を開始時間より後にしてください。") if self.start_time >= self.end_time
  end

  def start_time_ja
    self.start_time.strftime('%Y/%m/%d %H:%M')
  end

  def end_time_ja
    self.end_time.strftime('%Y/%m/%d %H:%M')
  end
end
