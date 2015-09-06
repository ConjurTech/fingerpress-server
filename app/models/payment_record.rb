class PaymentRecord < ActiveRecord::Base
  belongs_to :employee

  accepts_nested_attributes_for :employee, reject_if: :all_blank, allow_destroy: false
end
