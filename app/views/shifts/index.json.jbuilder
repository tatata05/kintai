json.array!(@events) do |shift|
  json.id shift.id
  json.title shift.employee.name
  json.start shift.start_time 
  json.end shift.end_time
end