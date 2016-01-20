class PaymentRecordTimeLog < ActiveRecord::Base
  belongs_to :payment_record_pay_scheme
  belongs_to :payment_record

  before_save :set_remarks
  before_save :calculate_pay, if: :payment_scheme_is_hourly_type?

  def payment_scheme_is_hourly_type?
    self.payment_record_pay_scheme.hourly_type?
  end

  def weekend?
    self.date_time_in.saturday? || self.date_time_in.sunday?
  end

  def public_holiday?
    Holiday.public_holiday?(self.date_time_in)
  end

  def set_remarks
    self.remarks = "#{'[Public Holiday]' if public_holiday?}#{'[Weekend]' if weekend?}#{'[Has OT]' if ot_hours > 0}"
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
    # weekend_pay = case self.payment_record_pay_scheme.weekend_type
    #                   when 'same_as_normal'
    #
    #                   when 'per_hour'
    #                     worked_hours
    #                   when 'multiplier'
    #
    #                   else
    #                     0
    #                 end
  end

  def public_holiday_pay
    public_holiday_hours * self.payment_record_pay_scheme.pay_public_holiday
  end

  def worked_hours
    TimeDifference.between(self.date_time_in, self.date_time_out).in_hours
  end

  def normal_hours
    normal_hours = worked_hours - ot_hours - weekend_hours - public_holiday_hours
    (normal_hours < 0) ? 0 : normal_hours
  end

  def ot_hours
    ot_hours = worked_hours - self.payment_record_pay_scheme.hours_per_day
    (ot_hours < 0) ? 0 : ot_hours
  end

  def weekend_hours
    weekend? ? worked_hours : 0
  end

  def public_holiday_hours
    public_holiday? ? worked_hours : 0
  end
end
