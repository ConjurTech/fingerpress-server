class PayScheme < ActiveRecord::Base
  belongs_to :pay_type
  belongs_to :ot_type
  belongs_to :public_holiday_type
  belongs_to :weekend_type
  has_many :employees, dependent: :nullify
  validates :name, :pay_type, :pay, presence: true

  def hourly_type?
    pay_type.name == 'Hourly' ? true : false
  end
end
