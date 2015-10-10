# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


pay_type_attributes = [
    { name: 'Monthly' },
    { name: 'Hourly'}
]

pay_type_attributes.each do |attributes|
  PayType.create(attributes) unless PayType.where(attributes).first
end

ot_type_attributes = [
    { name: 'None' },
    { name: 'PerHour'},
    { name: 'Multiplier'}
]

ot_type_attributes.each do |attributes|
  OtType.create(attributes) unless OtType.where(attributes).first
end

public_holiday_type_attributes = [
    { name: 'None' },
    { name: 'PerHour'},
    { name: 'Multiplier'}
]

public_holiday_type_attributes.each do |attributes|
  PublicHolidayType.create(attributes) unless PublicHolidayType.where(attributes).first
end

weekend_type_attributes = [
    { name: 'None' },
    { name: 'PerHour'},
    { name: 'Multiplier'}
]

weekend_type_attributes.each do |attributes|
  WeekendType.create(attributes) unless WeekendType.where(attributes).first
end

work_day_attributes = [
    { name: 'Monday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight },
    { name: 'Tuesday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight },
    { name: 'Wednesday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight },
    { name: 'Thursday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight },
    { name: 'Friday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight },
    { name: 'Saturday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight },
    { name: 'Sunday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight },
]

work_day_attributes.each do |attributes|
  Workday.create(attributes) unless Workday.where(attributes).first
end