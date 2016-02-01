class PayRoll < ActiveRecord::Base
  has_many :payment_records, dependent: :destroy
  has_many :employee_pay_rolls
  has_many :employees, through: :employee_pay_rolls
end
