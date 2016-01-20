class Holiday < ActiveRecord::Base
  validates :name, presence: true
  def self.public_holiday?(date)
    Holiday.where(day: date.beginning_of_day..date.end_of_day).present?
  end
end