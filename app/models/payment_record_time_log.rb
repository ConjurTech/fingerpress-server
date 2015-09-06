class PaymentRecordTimeLog < ActiveRecord::Base
  belongs_to :payment_record_pay_scheme
  belongs_to :payment_record
end
