class PaymentRecordPayScheme < ActiveRecord::Base
  belongs_to :pay_type
  belongs_to :ot_type
  belongs_to :weekend_type
  belongs_to :public_holiday_type
end
