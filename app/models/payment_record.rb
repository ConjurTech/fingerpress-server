class PaymentRecord < ActiveRecord::Base
  belongs_to :employee
  has_many :payment_record_time_logs, dependent: :destroy
  accepts_nested_attributes_for :employee, reject_if: :all_blank, allow_destroy: false
end
