class Config < ActiveRecord::Base
  has_many :workdays, -> { order(:id) }
  accepts_nested_attributes_for :workdays

  # return the number of ot hours based on the time range specified by workdays config and the timing inputted
  def ot_hours(date_time_in, date_time_out)
    wd = self.workdays.where(name: date_time_in.strftime("%A"), enabled: true).first
    return TimeDifference.between(date_time_in, date_time_out).in_hours if wd.blank?

    wd_start = DateTime.civil_from_format(:local, date_time_in.year, date_time_in.month, date_time_in.day) + wd.start_time_seconds.seconds
    wd_end = DateTime.civil_from_format(:local, date_time_in.year, date_time_in.month, date_time_in.day) + wd.end_time_seconds.seconds
    # http://stackoverflow.com/questions/325933/determine-whether-two-date-ranges-overlap find overlap by demorgans law of non overlap
    if (date_time_in < wd_end) and (date_time_out > wd_start)
      # only account for timings that occur after actual work hours
      if date_time_out > wd_end
        TimeDifference.between(wd_end, date_time_out).in_hours
      else
        0
      end
    else
      0
    end
  end

  def workday?(date)
    self.workdays.where(name: date.strftime("%A"), enabled: true).first.present?
  end

  def find_work_days
    self.workdays.map { |workday| workday.enabled ? workday.name[0, 3].downcase : nil }.compact
  end

  def config_adjusted_start_time(time_in)
    wd = self.workdays.where(name: time_in.strftime("%A"), enabled: true).first
    return time_in if wd.blank? || !self.auto_adjust_start_time?
    wd_start = DateTime.civil_from_format(:local, time_in.year, time_in.month, time_in.day) + wd.start_time_seconds.seconds
    difference = TimeDifference.between(wd_start, time_in).in_minutes

    if time_in < wd_start && difference <= self.start_time_lower_tolerance
      wd_start
    elsif time_in > wd_start && difference <= self.start_time_upper_tolerance
      wd_start
    else
      time_in
    end
  end

  def config_adjusted_end_time(time_in, time_out)
    wd = self.workdays.where(name: time_in.strftime("%A"), enabled: true).first
    return time_out if wd.blank? || !self.auto_adjust_end_time?
    wd_end = DateTime.civil_from_format(:local, time_in.year, time_in.month, time_in.day) + wd.end_time_seconds.seconds

    difference = TimeDifference.between(wd_end, time_out).in_minutes

    if time_out < wd_end && difference <= self.end_time_lower_tolerance
      wd_end
    elsif time_out > wd_end && difference <= self.end_time_upper_tolerance
      wd_end
    else
      time_out
    end
  end
end
