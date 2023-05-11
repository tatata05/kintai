json.array!(@events) do |shift|
  json.id shift.id
  json.start shift.start_time
  json.end shift.end_time

  if shift.absence.present? && shift.absence.status == "unapproved"
    json.color "#FE8212"
    json.title "[欠勤申請]"
    json.url employee_absence_path(shift.absence.id)
  else
    case shift.status
    when "unapproved"
      json.color "#CDC958"
      json.title "[シフト申請]"
    when "approved"
      json.color "#20B1C4"
      json.title "[確定]"
    end
    json.url employee_shift_path(shift.id)
  end
end