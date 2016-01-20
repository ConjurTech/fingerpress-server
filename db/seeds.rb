# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

work_day_attributes = [
    { name: 'Monday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight, enabled: true },
    { name: 'Tuesday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight, enabled: true },
    { name: 'Wednesday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight, enabled: true },
    { name: 'Thursday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight, enabled: true },
    { name: 'Friday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight, enabled: true },
    { name: 'Saturday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight, enabled: false },
    { name: 'Sunday', start_time_seconds: Time.parse('9:00').seconds_since_midnight, end_time_seconds: Time.parse('17:00').seconds_since_midnight, enabled: false },
]

work_day_attributes.each do |attributes|
  Workday.create(attributes) unless Workday.where(attributes).first
end