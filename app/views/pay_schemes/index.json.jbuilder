json.array!(@pay_schemes) do |pay_scheme|
  json.extract! pay_scheme, :id, :pay_type_id, :pay, :pay_ot, :pay_public_holiday
  json.url pay_scheme_url(pay_scheme, format: :json)
end
