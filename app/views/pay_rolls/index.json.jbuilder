json.array!(@pay_rolls) do |pay_roll|
  json.extract! pay_roll, :id, :start_date, :end_date
  json.url pay_roll_url(pay_roll, format: :json)
end
