class Holiday < ActiveRecord::Base
  def public_holiday?(date)
    Holiday.where(day: date).present?
  end
end