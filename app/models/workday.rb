class Workday < ActiveRecord::Base
  before_save :ensure_time_validity
  attr_accessor :start_time, :end_time

  def start_time
    Time.at(self[:start_time_seconds]).utc.strftime('%I:%M%p') unless self.start_time_seconds.blank?
  end

  def end_time
    Time.at(self[:end_time_seconds]).utc.strftime('%I:%M%p') unless self.end_time_seconds.blank?
  end

  def start_time=(time)
    self.start_time_seconds = Time.zone.parse(time).seconds_since_midnight
  end

  def end_time=(time)
    self.end_time_seconds = Time.zone.parse(time).seconds_since_midnight
  end

  def twentyfour_hr_start_time
    Time.at(self[:start_time_seconds]).utc.strftime('%H:%M')
  end

  def twentyfour_hr_end_time
    Time.at(self[:end_time_seconds]).utc.strftime('%H:%M')
  end

  def self.find_work_days
    Workday.all.map { |workday| workday.enabled ? workday.name[0, 3].downcase : nil }.compact
  end

  def ensure_time_validity
    self[:start_time_seconds] < self[:end_time_seconds]
  end

  def self.workday?(date)
    Workday.where(name: date.strftime("%A"), enabled: true).first.present?
  end

  # return the number of ot hours based on the time range specified by workdays config and the timing inputted
  def self.ot_hours(date_time_in, date_time_out)
    wd = Workday.where(name: date_time_in.strftime("%A"), enabled: true).first
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
end