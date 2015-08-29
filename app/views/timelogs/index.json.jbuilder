json.array!(@timelogs) do |timelog|
  json.extract! timelog, :id, :date_in, :date_out, :employee_id
  json.url timelog_url(timelog, format: :json)
end
