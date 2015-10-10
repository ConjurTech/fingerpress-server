class Workday < ActiveRecord::Base

  before_save :convert_to_seconds

  def start_time_field
    # Time.at(82800).utc.strftime("%I:%M%p")
    Time.at(start_time_seconds).strftime("%H:%M %P") if self.start_time_seconds.present?
  end

  def end_time_field
    Time.at(end_time_seconds).strftime("%H:%M %P") if self.end_time_seconds.present?
  end

  def start_time_field=(time)
    # Change back to datetime friendly format
    @start_time_field = Time.parse(time).strftime("%H:%M %P")
  end

  def end_time_field=(time)
    # Change back to datetime friendly format
    @end_time_field = Time.parse(time).strftime("%H:%M %P")
  end

  def convert_to_seconds
    return true if @start_time_field.blank?
    self.start_time_seconds = Time.parse("#{@start_time_field} ").seconds_since_midnight
    self.end_time_seconds = Time.parse("#{@end_time_field} ").seconds_since_midnight
  end

end
