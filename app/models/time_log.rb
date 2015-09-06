class TimeLog < ActiveRecord::Base
  belongs_to :employee
  belongs_to :pay_scheme
  belongs_to :payment_record
end
