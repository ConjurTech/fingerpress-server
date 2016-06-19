json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :sex, :birthdate, :joindate, :leavedate, :bankdetails, :fingerprint_id
  json.url employee_url(employee, format: :json)
end
