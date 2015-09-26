class PaymentRecord < ActiveRecord::Base
  belongs_to :employee, -> { with_deleted }
  has_many :payment_record_time_logs, dependent: :destroy
  has_many :time_logs, dependent: :nullify
  accepts_nested_attributes_for :employee, reject_if: :all_blank, allow_destroy: false
  before_save :set_paid_at

  def paid?
    self.paid_at.present?
  end

  def set_paid_at
    self.paid_at = Time.zone.now
  end

  def set_pay

  end
end
