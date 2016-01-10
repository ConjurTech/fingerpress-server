class TimeLog < ActiveRecord::Base
  attr_accessor :date_in, :time_in, :date_out, :time_out
  belongs_to :employee, -> { with_deleted }
  belongs_to :pay_scheme
  belongs_to :payment_record

  before_validation :convert_to_datetime, on: [:create, :update]
  validates :time_in, :time_out, :date_in, :date_out, :employee, :pay_scheme, presence: true
  validate :end_time_is_after_start_time


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
    if @date_time_in_date_field.blank? || @date_time_in_time_field.blank?
      self.date_time_in = nil
    else
      self.date_time_in = Time.zone.parse("#{@date_time_in_date_field} #{@date_time_in_time_field}")
    end

    if @date_time_out_date_field.blank? || @date_time_out_time_field.blank?
      self.date_time_out = nil
    else
      self.date_time_out = Time.zone.parse("#{@date_time_out_date_field} #{@date_time_out_time_field}")
    end
  end


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
end
