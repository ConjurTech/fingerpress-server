class TimeLog < ActiveRecord::Base
  attr_accessor :date_in, :time_in, :date_out, :time_out
  belongs_to :employee, -> { with_deleted }
  belongs_to :pay_scheme
  belongs_to :payment_record

  before_validation :convert_to_datetime, on: [:create, :update]
  # validates :time_in, :time_out, :date_in, :date_out, :employee, :pay_scheme, presence: true
  validates :employee, presence: true
  # validate :end_time_is_after_start_time
  before_save :adjust_based_on_config, :set_validity, :set_pay_scheme_from_employee

  scope :complete, -> { where('date_time_in IS NOT NULL AND date_time_out IS NOT NULL') }

  def age
    self.any_date_time_present? ? TimeDifference.between(first_available_date_time, DateTime.now).try(:in_hours) || 0 : 0
  end

  def any_date_time_present?
    self.date_time_in.present? || self.date_time_out.present?
  end

  def both_date_time_present?
    self.date_time_in.present? && self.date_time_out.present?
  end

  def first_available_date_time
    return date_time_in if date_time_in.present?
    return date_time_out if date_time_out.present?
    nil
  end

  def date_in
    return nil unless self[:date_time_in]
    date_time_in.strftime("%e %B, %Y")
  end

  def time_in
    return nil unless self[:date_time_in]
    date_time_in.strftime("%I:%M%p")
  end

  def time_in=(time)
    # Change back to datetime friendly format
    @date_time_in_time_field = Time.parse(time).strftime("%H:%M:%S") if time.present?
  end

  def date_in=(date)
    # Change back to datetime friendly format
    @date_time_in_date_field = Date.parse(date).strftime("%Y-%m-%d") if date.present?
  end

  def date_out
    return nil unless self[:date_time_out]
    date_time_out.strftime("%e %B, %Y")
  end

  def time_out
    return nil unless self[:date_time_out]
    date_time_out.strftime("%I:%M%p")
  end

  def date_out=(date)
    # Change back to datetime friendly format
    @date_time_out_date_field = Date.parse(date).strftime("%Y-%m-%d") if date.present?
  end

  def time_out=(time)
    # Change back to datetime friendly format
    @date_time_out_time_field = Time.parse(time).strftime("%H:%M:%S") if time.present?
  end

  def convert_to_datetime
    if @date_time_in_date_field.present? && @date_time_in_time_field.present?
      self.date_time_in = Time.zone.parse("#{@date_time_in_date_field} #{@date_time_in_time_field}")
    end
    if @date_time_out_date_field.present? && @date_time_out_time_field.present?
      self.date_time_out = Time.zone.parse("#{@date_time_out_date_field} #{@date_time_out_time_field}")
    end
  end

  def datetime_fields_present?
    @date_time_in_date_field.present? && @date_time_in_time_field.present?
  end

  # TIME LOG PAY CALCULATION METHODS

  def payment_scheme_is_hourly_type?
    self.pay_scheme.hourly?
  end

  def weekend?
    self.date_time_in.saturday? || self.date_time_in.sunday?
  end

  def public_holiday?
    Holiday.public_holiday?(self.date_time_in)
  end

  def workday?
    TimeLogConfig.first.workday?(self.date_time_in)
  end

  def has_ot?
    ot_hours > 0 && !public_holiday? && !weekend?
  end

  def public_holiday_name
    Holiday.public_holiday_name(self.date_time_in)
  end

  def remarks
    if time_log_is_valid
      "#{'[Public Holiday (' + public_holiday_name + ')]' if public_holiday?}#{'[Weekend]' if weekend?}#{'[Has OT]' if has_ot?}"
    else
      "Invalid"
    end
  end

  def calculate_pay
    self.pay = total_pay
  end

  # Calculate pay functions

  def total_pay
    normal_pay + ot_pay + weekend_pay + public_holiday_pay
  end

  def normal_pay
    normal_hours * self.pay_scheme.pay
  end

  def ot_pay
    case self.pay_scheme.ot_type
      when 'same_as_normal'
        ot_hours * self.pay_scheme.pay
      when 'per_hour'
        ot_hours * self.pay_scheme.pay_ot
      when 'multiplier'
        ot_hours * self.pay_scheme.pay * self.pay_scheme.ot_multiplier
      else
        0
    end
  end

  def weekend_pay
    case self.pay_scheme.weekend_type
      when 'same_as_normal'
        weekend_hours * self.pay_scheme.pay
      when 'per_hour'
        weekend_hours * self.pay_scheme.pay_weekend
      when 'multiplier'
        weekend_hours * self.pay_scheme.pay * self.pay_scheme.weekend_multiplier
      else
        0
    end
  end

  def public_holiday_pay
    case self.pay_scheme.public_holiday_type
      when 'same_as_normal'
        public_holiday_hours * self.pay_scheme.pay
      when 'per_hour'
        public_holiday_hours * self.pay_scheme.pay_public_holiday
      when 'multiplier'
        public_holiday_hours * self.pay_scheme.pay * self.pay_scheme.public_holiday_multiplier
      else
        0
    end
  end

  def worked_hours
    TimeDifference.between(self.date_time_in, self.date_time_out).in_hours
  end

  def normal_hours
    normal_hours = worked_hours - ot_hours - weekend_hours - public_holiday_hours
    (normal_hours < 0) ? 0 : normal_hours
  end

  def ot_hours
    hours = TimeLogConfig.first.ot_hours(self.date_time_in, self.date_time_out)
    (weekend? || public_holiday?) ? 0 : hours
  end

  def weekend_hours
    (weekend? && !public_holiday? && !workday?) ? worked_hours : 0
  end

  def public_holiday_hours
    public_holiday? ? worked_hours : 0
  end

  # END CALCULATE PAY FUNCTIONS

  private
  def end_time_is_after_start_time
    return false if @date_time_in_date_field.blank? || @date_time_in_time_field.blank? || @date_time_out_date_field.blank? || @date_time_out_time_field.blank?
    starts_at = Time.zone.parse("#{@date_time_in_date_field} #{@date_time_in_time_field}")
    ends_at = Time.zone.parse("#{@date_time_out_date_field} #{@date_time_out_time_field}")
    if starts_at > ends_at
      errors.add(:base, "End date/time cannot be BEFORE the start date/time")
      false
    end
  end

  def set_validity
    self.time_log_is_valid = self.date_time_in.present? && self.date_time_out.present? && TimeDifference.between(self.date_time_in, self.date_time_out).in_hours <= 24
    true
  end

  def set_pay_scheme_from_employee
    self.pay_scheme = self.employee.pay_scheme
  end

  def adjust_based_on_config
    self.date_time_in = TimeLogConfig.first.config_adjusted_start_time(self.date_time_in) if self.date_time_in.present?
    self.date_time_out = TimeLogConfig.first.config_adjusted_end_time(self.date_time_in, self.date_time_out) if self.date_time_out.present? && self.date_time_in.present?
  end
end
