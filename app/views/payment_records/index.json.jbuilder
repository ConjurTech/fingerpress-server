json.array!(@payment_records) do |payment_record|
  json.extract! payment_record, :id
  json.url payment_record_url(payment_record, format: :json)
end
