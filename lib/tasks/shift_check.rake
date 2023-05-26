namespace :shift_check do
  desc "シフト申請がされてから5日以上放置されていた時に通知を行う"
  task shift_check_approval_pending: :environment do
    time = Time.now
    shifts = Shift.where(status: "unapproved")
    shifts.each do |shift|
      if shift.created_at.since(5.days) < time && Notification.where(employee_id: shift.employee.id, shift_id: shift.id, kind: "approval_pending").count < 1
        # 重複したデータを作成させないため、find_or_create_byを使用(if文を使用するより簡潔に記載できる)
        Notification.find_or_create_by(employee_id: shift.employee.id, shift_id: shift.id, kind: "approval_pending")
      end
    end
  end
end

namespace :absence_check do
  desc "欠勤申請がされてから1日以上放置されていた時に通知を行う"
  task absence_check_approval_pending: :environment do
    time = Time.now
    absences = Absence.where(status: "unapproved")
    absences.each do |absence|
      if absence.created_at.since(1.day) < time && Notification.where(employee_id: absence.shift.employee.id, absence_id: absence.id, kind: "approval_pending").count < 1
        Notification.find_or_create_by(employee_id: absence.shift.employee.id, absence_id: absence.id, kind: "approval_pending")
      end
    end
  end
end

namespace :shift_applied_check do
  desc "毎月20日にシフト申請を全くしていない従業員がいた時に通知を行う"
  task shift_applied: :environment do
    employees = Employee.all
    shifts = Shift.where("start_time > ? and ? > start_time", Date.today.at_beginning_of_month.next_month, Date.today.end_of_month.next_month)
    employees.each do |employee|
      if shifts.where(employee_id: employee.id).count > 0
        Notification.create(employee_id: employee.id, kind: "unapplied")
      end
    end
  end
end

namespace :notification_destroy do
  desc "シフト未申請通知が毎月1日に残っていた時に通知を削除する"
  task destroy_unapplied: :environment do
    Notification.where(kind: "unapplied").destroy_all
  end
end
