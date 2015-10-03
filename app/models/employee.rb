class Employee < ActiveRecord::Base
  acts_as_paranoid
  has_many :time_logs
  belongs_to :pay_scheme

  def time_logs_between(start_date, end_date)
    self.time_logs.where(date_time_in: start_date..end_date, payment_record: nil)
  end
end
