# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# ALL environments

# Workdays
work_day_attributes = [
    {name: 'Monday', start_time_seconds: Time.zone.parse('9:00').seconds_since_midnight, end_time_seconds: Time.zone.parse('17:00').seconds_since_midnight, enabled: true},
    {name: 'Tuesday', start_time_seconds: Time.zone.parse('9:00').seconds_since_midnight, end_time_seconds: Time.zone.parse('17:00').seconds_since_midnight, enabled: true},
    {name: 'Wednesday', start_time_seconds: Time.zone.parse('9:00').seconds_since_midnight, end_time_seconds: Time.zone.parse('17:00').seconds_since_midnight, enabled: true},
    {name: 'Thursday', start_time_seconds: Time.zone.parse('9:00').seconds_since_midnight, end_time_seconds: Time.zone.parse('17:00').seconds_since_midnight, enabled: true},
    {name: 'Friday', start_time_seconds: Time.zone.parse('9:00').seconds_since_midnight, end_time_seconds: Time.zone.parse('17:00').seconds_since_midnight, enabled: true},
    {name: 'Saturday', start_time_seconds: Time.zone.parse('9:00').seconds_since_midnight, end_time_seconds: Time.zone.parse('17:00').seconds_since_midnight, enabled: false},
    {name: 'Sunday', start_time_seconds: Time.zone.parse('9:00').seconds_since_midnight, end_time_seconds: Time.zone.parse('17:00').seconds_since_midnight, enabled: false}
]
work_day_attributes.each do |attributes|
  puts attributes
  puts Workday.where(attributes).first.present?
  Workday.create!(attributes) unless Workday.where(attributes).first
end

# Pay Schemes
pay_scheme_attributes = [
    {pay: 1, pay_ot: 10, pay_public_holiday: 1000, name: "Worker's pay", ot_multiplier: 0, public_holiday_multiplier: 0,
     pay_weekend: 100, weekend_multiplier: 0, pay_type: "hourly", ot_type: "per_hour", weekend_type: "per_hour", public_holiday_type: "per_hour"},
    {pay: 10000, pay_ot: 10, pay_public_holiday: 1000, name: "Manager's pay", ot_multiplier: 0, public_holiday_multiplier: 0,
     pay_weekend: 100, weekend_multiplier: 0, pay_type: "monthly", ot_type: "per_hour", weekend_type: "per_hour", public_holiday_type: "per_hour"}
]
pay_scheme_attributes.each do |attributes|
  PayScheme.create!(attributes) unless PayScheme.where(attributes).first
end

if Rails.env.production?

end

if Rails.env.development?
  # Create Admin
  admin_attributes = [
      {email: "admin@conjur.tech", password:"123123123"},
  ]
  admin_attributes.each do |attributes|
    Admin.create!(attributes) unless Admin.where(email: "admin@conjur.tech").first
  end

  # Create Employee
  employee_attributes = [
      {name: "Lu Han's apprentice", pay_scheme_id: PayScheme.first.id},
  ]
  employee_attributes.each do |attributes|
    Employee.create!(attributes) unless Employee.where(attributes).first
  end

  # Create Timelogs
  employee_id = Employee.first.id
  timelog_attributes = [
      {date_time_in: DateTime.civil_from_format(:local, 2016,1,20,12), date_time_out: DateTime.civil_from_format(:local, 2016,1,20,17), employee_id: employee_id, pay_scheme_id: PayScheme.first.id},
      {date_time_in: DateTime.civil_from_format(:local, 2016,1,22,12), date_time_out: DateTime.civil_from_format(:local, 2016,1,22,17), employee_id: employee_id, pay_scheme_id: PayScheme.first.id},
      {date_time_in: DateTime.civil_from_format(:local, 2016,1,23,12), date_time_out: DateTime.civil_from_format(:local, 2016,1,23,17), employee_id: employee_id, pay_scheme_id: PayScheme.first.id},
      {date_time_in: DateTime.civil_from_format(:local, 2016,1,21,17), date_time_out: DateTime.civil_from_format(:local, 2016,1,21,19), employee_id: employee_id, pay_scheme_id: PayScheme.first.id},
      {date_time_in: DateTime.civil_from_format(:local, 2016,1,24,7), date_time_out: DateTime.civil_from_format(:local, 2016,1,24,17), employee_id: employee_id, pay_scheme_id: PayScheme.first.id}
  ]
  timelog_attributes.each do |attributes|
    puts TimeLog.where(attributes).first.present?
    TimeLog.create!(attributes) unless TimeLog.where(attributes).first
  end

  # Create Holidays
  holiday_attributes = [
      {day: DateTime.civil_from_format(:local, 2016,1,22), name: "A Fun Holiday"},
      {day: DateTime.civil_from_format(:local, 2016,1,23), name: "A More Fun Holiday"}
  ]
  holiday_attributes.each do |attributes|
    puts Holiday.where(attributes).first.present?
    Holiday.create!(attributes) unless Holiday.where(attributes).first
  end
end