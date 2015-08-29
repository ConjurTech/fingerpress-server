class TimeLog < ActiveRecord::Base
  belongs_to :employee
  belongs_to :pay_scheme
end
