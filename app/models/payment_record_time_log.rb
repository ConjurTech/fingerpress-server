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

  def calculate_pay

  end

  # Calculate pay functions
  def total_pay
    normal_pay + ot_pay + weekend_pay + public_holiday_pay
  end

  def normal_pay
    normal_hours * self.payment_record_pay_scheme.pay
  end

  def ot_pay
    ot_hours * self.payment_record_pay_scheme.pay_ot
  end

  def weekend_pay
    weekend_hours * self.payment_record_pay_scheme.pay_weekend
  end

  def public_holiday_pay
    public_holiday_hours * self.payment_record_pay_scheme.pay_public_holiday
  end

  def normal_hours

  end

  def ot_hours

  end

  def weekend_hours

  end

  def public_holiday_hours

  end

  def worked_hours

  end
end
