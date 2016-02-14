# BusinessTime::Config.load("#{Rails.root}/config/business_time.yml")

# or you can configure it manually:  look at me!  I'm Tim Ferriss!
#  BusinessTime::Config.beginning_of_workday = "10:00 am"
#  BusinessTime::Config.end_of_workday = "11:30 am"
#  BusinessTime::Config.holidays << Date.parse("August 4th, 2010")


#
# BusinessTime::Config.work_week = Workday.find_work_days
# #BusinessTime::Config.work_week = ['Mon']
#
# @work_hours_list = {}
# Workday.find_work_days.each do |wd|
#   if wd == "Mon"
#     @work_hours_list[:mon]=[Workday.find(1).twentyfour_hr_start_time, Workday.find(1).twentyfour_hr_end_time]
#   elsif wd == "Tue"
#     @work_hours_list[:tue]=[Workday.find(2).twentyfour_hr_start_time, Workday.find(2).twentyfour_hr_end_time]
#   elsif wd == "Wed"
#     @work_hours_list[:wed]=[Workday.find(3).twentyfour_hr_start_time, Workday.find(3).twentyfour_hr_end_time]
#   elsif wd == "Thu"
#     @work_hours_list[:thu]=[Workday.find(4).twentyfour_hr_start_time, Workday.find(4).twentyfour_hr_end_time]
#   elsif wd == "Fri"
#     @work_hours_list[:fri]=[Workday.find(5).twentyfour_hr_start_time, Workday.find(5).twentyfour_hr_end_time]
#   elsif wd == "Sat"
#     @work_hours_list[:sat]=[Workday.find(6).twentyfour_hr_start_time, Workday.find(6).twentyfour_hr_end_time]
#   elsif wd == "Sun"
#     @work_hours_list[:sun]=[Workday.find(7).twentyfour_hr_start_time, Workday.find(7).twentyfour_hr_end_time]
#   end
# end
# BusinessTime::Config.work_hours = @work_hours_list

# BusinessTime::Config.work_hours = {
#     :mon => [Workday.find(1).twentyfour_hr_start_time, Workday.find(1).twentyfour_hr_end_time],
#     :tue => [Workday.find(2).twentyfour_hr_start_time, Workday.find(2).twentyfour_hr_end_time],
#     :wed => [Workday.find(3).twentyfour_hr_start_time, Workday.find(3).twentyfour_hr_end_time],
#     :thu => [Workday.find(4).twentyfour_hr_start_time, Workday.find(4).twentyfour_hr_end_time],
#     :fri => [Workday.find(5).twentyfour_hr_start_time, Workday.find(5).twentyfour_hr_end_time]
#     # :sat=>[Workday.find(6).twentyfour_hr_start_time,Workday.find(6).twentyfour_hr_end_time],
#     # :sun=>[Workday.find(7).twentyfour_hr_start_time,Workday.find(7).twentyfour_hr_end_time]
# }