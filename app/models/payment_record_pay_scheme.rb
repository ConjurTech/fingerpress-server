class PaymentRecordPayScheme < ActiveRecord::Base
  validates :name, :pay_type, :pay, presence: true

  def hourly?
    pay_type == 'hourly'
  end

  def monthly?
    pay_type == 'monthly'
  end
end
