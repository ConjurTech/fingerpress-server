json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :day
  json.url holiday_url(holiday, format: :json)
end
