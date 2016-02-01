class PaymentRecord < ActiveRecord::Base
  belongs_to :employee, -> { with_deleted }
  has_many :payment_record_time_logs, dependent: :destroy
  has_many :time_logs, dependent: :nullify
  belongs_to :payment_record_pay_scheme
  belongs_to :pay_roll

  validates :employee, :start_date, :end_date, presence: true

  accepts_nested_attributes_for :employee, reject_if: :all_blank, allow_destroy: false
  before_save :set_paid_at, :set_payment_record_pay_scheme, :calculate_pay

  def date_range_selected
    "#{self.start_date.to_date.to_s(:long)} TO #{self.end_date.to_date.to_s(:long)}"
  end

  def number_of_months
    (self.end_date.year - self.start_date.year) * 12 + self.end_date.month - self.start_date.month - (self.end_date.day >= self.start_date.day ? 0 : 1)
  end

  def calculate_pay
    pay = 0
    if self.payment_record_pay_scheme.monthly?
      # get months in between time period
      pay = number_of_months * payment_record_pay_scheme.pay
    else
      self.payment_record_time_logs.each do |payment_record_time_log|
        pay += payment_record_time_log.total_pay
      end
    end
    self.total_pay = pay
  end

  private

  def set_paid_at
    self.paid_at = Time.zone.now if self.paid?
  end

  def set_payment_record_pay_scheme
    employee = self.employee
    pay_scheme = PaymentRecordPayScheme.new(pay_type: employee.pay_scheme.pay_type,
                                            pay: employee.pay_scheme.pay,
                                            pay_ot: employee.pay_scheme.pay_ot,
                                            pay_public_holiday: employee.pay_scheme.pay_public_holiday,
                                            name: employee.pay_scheme.name,
                                            ot_multiplier: employee.pay_scheme.ot_multiplier,
                                            ot_time_range_start: employee.pay_scheme.ot_time_range_start,
                                            ot_time_range_end: employee.pay_scheme.ot_time_range_end,
                                            public_holiday_multiplier: employee.pay_scheme.public_holiday_multiplier,
                                            pay_weekend: employee.pay_scheme.pay_weekend,
                                            weekend_multiplier: employee.pay_scheme.weekend_multiplier,
                                            ot_type: employee.pay_scheme.ot_type,
                                            public_holiday_type: employee.pay_scheme.public_holiday_type,
                                            weekend_type: employee.pay_scheme.weekend_type,
                                            hours_per_day: employee.pay_scheme.hours_per_day)
    pay_scheme.save
    self.payment_record_pay_scheme = pay_scheme
  end
end
