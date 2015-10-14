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
      self[:start_time_seconds] = Time.parse(time).seconds_since_midnight muthafarking error TypeError: no implicit conversion of Float into String
    end
  end

  def end_time_seconds=(time)
    if time.blank?
      self[:end_time_seconds] = nil
    else
      self[:end_time_seconds] = Time.parse(time).seconds_since_midnight
    end
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
end
