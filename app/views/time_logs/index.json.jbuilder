json.array!(@time_logs) do |time_log|
  json.extract! time_log, :id, :date_in, :date_out, :employee_id, :pay_scheme_id
  json.url time_log_url(time_log, format: :json)
end
