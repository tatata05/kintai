json.array!(@events) do |shift|
  json.id shift.id
  json.title shift.employee.name
  json.start shift.start_time 
  json.end shift.end_time

  if shift.status == "unapproved"
    json.color "#A2E900"
  elsif shift.status == "approved"
    json.color "#80A0D8"
  else
    json.color "#ED570D"
  end
end