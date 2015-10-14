class Workday < ActiveRecord::Base

  def start_time_seconds
    return nil unless self[:start_time_seconds]
    Time.at(self[:start_time_seconds]).utc.strftime('%I:%M%p')
  end
  def end_time_seconds
    return nil unless self[:end_time_seconds]
    Time.at(self[:end_time_seconds]).utc.strftime('%I:%M%p')
  end
  def start_time_seconds=(time)
    if time.blank?
      self[:start_time_seconds] = nil
    else
      self[:start_time_seconds] = Time.parse(time).seconds_since_midnight
    end
  end
  def end_time_seconds=(time)
    if time.blank?
      self[:end_time_seconds] = nil
    else
      self[:end_time_seconds] = Time.parse(time).seconds_since_midnight
    end
  end

end
