class EmployeePayRoll < ActiveRecord::Base
  belongs_to :employee
  belongs_to :pay_roll
end
