class PayScheme < ActiveRecord::Base
  has_many :employees, dependent: :nullify

  after_initialize :init

  validates :name, :pay_type, :pay, presence: true
  validates :pay, :pay_ot, :pay_weekend, :pay_public_holiday, numericality: { greater_than_or_equal_to: 0 }

  def hourly_type?
    pay_type == :hourly
  end

  private
  def init
    if self.new_record?
      # values will be available for new record forms
      self.pay_type ||= :hourly
      self.ot_type ||= :same_as_normal
      self.weekend_type ||= :same_as_normal
      self.public_holiday_type ||= :same_as_normal
      self.pay ||= 0
      self.pay_ot ||= 0
      self.pay_weekend ||= 0
      self.pay_public_holiday ||= 0
      self.ot_multiplier ||= 0
      self.weekend_multiplier ||= 0
      self.public_holiday_multiplier ||= 0
    end
  end
end
