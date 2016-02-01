class PaymentRecordPayScheme < ActiveRecord::Base
  validates :name, :pay_type, :pay, presence: true

  def hourly?
    pay_type == 'hourly'
  end

  def monthly?
    pay_type == 'monthly'
  end
  
  def self.new_from_pay_scheme(pay_scheme)
    PaymentRecordPayScheme.new(pay_type: pay_scheme.pay_type,
                               pay: pay_scheme.pay,
                               pay_ot: pay_scheme.pay_ot,
                               pay_public_holiday: pay_scheme.pay_public_holiday,
                               name: pay_scheme.name,
                               ot_multiplier: pay_scheme.ot_multiplier,
                               ot_time_range_start: pay_scheme.ot_time_range_start,
                               ot_time_range_end: pay_scheme.ot_time_range_end,
                               public_holiday_multiplier: pay_scheme.public_holiday_multiplier,
                               pay_weekend: pay_scheme.pay_weekend,
                               weekend_multiplier: pay_scheme.weekend_multiplier,
                               ot_type: pay_scheme.ot_type,
                               public_holiday_type: pay_scheme.public_holiday_type,
                               weekend_type: pay_scheme.weekend_type,
                               hours_per_day: pay_scheme.hours_per_day)
  end
end
