class TimeLog < ActiveRecord::Base
  belongs_to :employee
  belongs_to :pay_scheme
  belongs_to :payment_record

  before_save :convert_to_datetime

  def date_time_in_date_field
    date_time_in.strftime("%d/%m/%Y") if date_time_in.present?
  end

  def date_time_in_time_field
    date_time_in.strftime("%I:%M%p") if date_time_in.present?
  end

  def date_time_in_date_field=(date)
    # Change back to datetime friendly format
    @date_time_in_date_field = Date.parse(date).strftime("%Y-%m-%d")
  end

  def date_time_in_time_field=(time)
    # Change back to datetime friendly format
    @date_time_in_time_field = Time.parse(time).strftime("%H:%M:%S")
  end

  def date_time_out_date_field
    date_time_out.strftime("%d/%m/%Y") if date_time_out.present?
  end

  def date_time_out_time_field
    date_time_out.strftime("%I:%M%p") if date_time_out.present?
  end

  def date_time_out_date_field=(date)
    # Change back to datetime friendly format
    @date_time_out_date_field = Date.parse(date).strftime("%Y-%m-%d")
  end

  def date_time_out_time_field=(time)
    # Change back to datetime friendly format
    @date_time_out_time_field = Time.parse(time).strftime("%H:%M:%S")
  end

  def convert_to_datetime
    self.date_time_in = DateTime.parse("#{@date_time_in_date_field} #{@date_time_in_time_field}")
    self.date_time_out = DateTime.parse("#{@date_time_out_date_field} #{@date_time_out_time_field}")
  end
end
