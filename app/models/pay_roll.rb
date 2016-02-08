class PayRoll < ActiveRecord::Base
  has_many :payment_records, dependent: :destroy
  has_many :employee_pay_rolls, dependent: :destroy
  has_many :employees, through: :employee_pay_rolls

  def mark_all_paid
    self.payment_records.each do |record|
      record.update_columns(paid: true, paid_at: DateTime.now)
    end
  end

  def all_paid?
    self.payment_records.pluck(:paid).all?
  end
end
