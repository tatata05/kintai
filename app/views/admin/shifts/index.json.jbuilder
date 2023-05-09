json.array!(@events) do |shift|
  json.id shift.id
  json.start shift.start_time
  json.end shift.end_time

  if shift.absence.present? && shift.absence.status == "unapproved"
    json.color "#FE8212"
    json.title "[欠勤申請] #{shift.employee.name}"
    json.url admin_absence_path(shift.absence.id)
  else
    case shift.status
    when "unapproved"
      json.color "#CDC958"
      json.title "[シフト申請] #{shift.employee.name}"
    when "approved"
      json.color "#20B1C4"
      json.title "[確定] #{shift.employee.name}"
    end
    json.url admin_shift_path(shift.id)
  end
end
