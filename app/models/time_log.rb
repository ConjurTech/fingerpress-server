class TimeLog < ActiveRecord::Base
  belongs_to :employee, -> { with_deleted }
  belongs_to :pay_scheme
  belongs_to :payment_record

  before_save :convert_to_datetime

  def time_in
    date_time_in.strftime("%e %B, %Y") if date_time_in.present?
  end

  def date_in
    date_time_in.strftime("%I:%M%p") if date_time_in.present?
  end

  def time_in=(time)
    # Change back to datetime friendly format
    @date_time_in_time_field = Time.parse(time).strftime("%H:%M:%S")
  end

  def date_in=(date)
    # Change back to datetime friendly format
    @date_time_in_date_field = Date.parse(date).strftime("%Y-%m-%d")
  end

  def date_out
    date_time_out.strftime("%e %B, %Y") if date_time_out.present?
  end

  def time_out
    date_time_out.strftime("%I:%M%p") if date_time_out.present?
  end

  def date_out=(date)
    # Change back to datetime friendly format
    @date_time_out_date_field = Date.parse(date).strftime("%Y-%m-%d")
  end

  def time_out=(time)
    # Change back to datetime friendly format
    @date_time_out_time_field = Time.parse(time).strftime("%H:%M:%S")
  end

  def convert_to_datetime
    return true if @date_time_in_date_field.blank? || @date_time_in_time_field.blank?
    self.date_time_in = Time.zone.parse("#{@date_time_in_date_field} #{@date_time_in_time_field}")
    self.date_time_out = Time.zone.parse("#{@date_time_out_date_field} #{@date_time_out_time_field}")
  end
end
