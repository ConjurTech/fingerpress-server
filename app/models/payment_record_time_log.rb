class PaymentRecordTimeLog < ActiveRecord::Base
  belongs_to :payment_record_pay_scheme
  belongs_to :payment_record

  before_save :calculate_pay, if: :payment_scheme_is_hourly_type?


  def payment_scheme_is_hourly_type?
    self.payment_record_pay_scheme.hourly_type?
  end

  def public_holiday?(date)
    Holiday.public_holiday?(date)
  end
end
