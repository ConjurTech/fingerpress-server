class Holiday < ActiveRecord::Base
  validates :name, presence: true
  def public_holiday?(date)
    Holiday.where(day: date).present?
  end
end