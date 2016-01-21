class StatisticsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @employees = Employee.all
    @time_logs = @employee.time_logs
    @hrs_logged_overall = {}
    @hrs_logged = @time_logs.map{|tl| [tl.date_time_in, TimeDifference.between(tl.date_time_in, tl.date_time_out).in_hours]}
  end
end
