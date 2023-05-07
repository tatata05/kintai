json.array!(@events) do |shift|
  json.id shift.id
  json.start shift.start_time
  json.end shift.end_time

  if shift.absence.present? 
    case shift.absence.status
    when "unapproved"
      json.color "#FE8212"
    when "approved"
      json.color "#CDC958"
    when "rejected"
      json.color "#89EE15"
    end
    json.title "[欠勤] #{shift.employee.name}"
    json.url employee_absence_path(shift.absence.id)
  else
    case shift.status
    when "unapproved"
      json.color "#20B1C4"
    when "approved"
      json.color "#2B425A"
    when "rejected"
      json.color "#ED570D"
    end
    json.title "[シフト] #{shift.employee.name}"
    json.url employee_shift_path(shift.id)
  end
end
