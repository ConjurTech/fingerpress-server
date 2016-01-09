class PaymentRecord < ActiveRecord::Base
  belongs_to :employee, -> { with_deleted }
  has_many :payment_record_time_logs, dependent: :destroy
  has_many :time_logs, dependent: :nullify
  has_one :payment_record_pay_scheme

  accepts_nested_attributes_for :employee, reject_if: :all_blank, allow_destroy: false
  before_save :set_paid_at, :calculate_pay

  def paid?
    self.paid_at.present?
  end

  def set_paid_at
    self.paid_at = Time.zone.now
  end

  def calculate_pay
    # if a timelog exist, save take/save from first time log
    # else take payscheme from employee
    #total_ot_hours = 0
    total_ot_pay = 0
    self.payment_record_time_logs.each do |payment_record_time_log|
      #total_ot_hours += payment_record_time_log.ot_hours
      total_ot_pay += payment_record_time_log.ot_hours * payment_record_time_log.payment_record_pay_scheme.pay_ot
      #* self.payment_record_pay_scheme.pay_ot
    end
    # if self.payment_record_pay_scheme.name == 'Monthly'
    #   # get months in between time period
    #   number_of_months(self.start_date, self.end_date)
    #   # get ot
    # end
  end

  def is_public_holiday(date)
    false
  end

  private
    def number_of_months(start_date, end_date)

    end
end
