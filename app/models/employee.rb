class Employee < ActiveRecord::Base
  acts_as_paranoid
  has_many :time_logs
  has_many :employee_pay_rolls
  has_many :pay_rolls, through: :employee_pay_rolls
  belongs_to :pay_scheme
  validates :pay_scheme, presence: true

  def valid_time_logs_between(start_date, end_date)
    self.time_logs.where(date_time_in: start_date..(end_date+1), payment_record: nil, time_log_is_valid: true)
  end
end
