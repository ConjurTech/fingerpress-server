class Holiday < ActiveRecord::Base
  validates :name, :day, presence: true
  def self.public_holiday?(date)
    Holiday.where(day: date.beginning_of_day..date.end_of_day).present?
  end

      def self.public_holiday_name(date)
    "#{Holiday.where(day: date.beginning_of_day..date.end_of_day).first.try(:name)}"
  end
end