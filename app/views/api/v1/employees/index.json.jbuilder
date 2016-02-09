json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :sex, :birthdate, :joindate, :leavedate, :bankdetails
  json.url employee_url(employee, format: :json)
end
