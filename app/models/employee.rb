class Employee < ActiveRecord::Base
  has_many :timelogs
end
