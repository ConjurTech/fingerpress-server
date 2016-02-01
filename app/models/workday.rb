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
end