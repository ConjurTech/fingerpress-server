class Employee < ActiveRecord::Base
  acts_as_paranoid
  has_many :time_logs
  belongs_to :pay_scheme
end
