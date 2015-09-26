json.array!(@payment_record_pay_schemes) do |payment_record_pay_scheme|
  json.extract! payment_record_pay_scheme, :id
  json.url payment_record_pay_scheme_url(payment_record_pay_scheme, format: :json)
end
