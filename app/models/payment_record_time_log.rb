class PaymentRecordTimeLog < ActiveRecord::Base
  belongs_to :payment_record_pay_scheme
  belongs_to :payment_record

  before_save :calculate_pay, if: :payment_scheme_is_hourly_type?

    def calculate_pay
      # for every timelog, get hrs worked, get payscheme, calculate pay based on payscheme
      pay_scheme = self.payment_record_pay_scheme
      shift_pay = 0.0
      # Total Hours worked = endtime-starttime
      hours_worked = TimeDifference.between(self.date_time_in, self.date_time_out).in_hours
      hourly_normal_pay = pay_scheme.pay

      # Check if start date is weekend
      if (self.date_time_in.saturday? || self.date_time_in.sunday?) && pay_scheme.weekend_type.name != 'None'

        if pay_scheme.weekend_type.name == 'PerHour'
          # calc by hours_work * weekend_pay
          shift_pay = hours_worked * pay_scheme.pay_weekend
        elsif pay_scheme.weekend_type.name == 'Multiplier'
          # calc by hours_work * weekend_pay_multiplier * normal_pay
          shift_pay = hours_worked * pay_scheme.weekend_multiplier * hourly_normal_pay
        end
        # Check if start date is public holiday
      elsif Holiday.new.public_holiday?(self.date_time_in) && pay_scheme.public_holiday_type.name != 'None'
        if pay_scheme.public_holiday_type.name == 'PerHour'
          # calc by hours_work * public_holiday_pay
          shift_pay = hours_worked * pay_scheme.pay_public_holiday
        elsif pay_scheme.public_holiday_type.name == 'Multiplier'
          # calc by hours_work * public_holiday_pay_multiplier * normal_pay
          shift_pay = hours_worked * pay_scheme.public_holiday_multiplier * hourly_normal_pay
        end
        # Normal day!
      else
        # If there is a need to check for ot calculations
        if pay_scheme.ot_type.name != 'None'
          byebug
          # see whether its range or according to specified hours
          # if there is a range specified
          if pay_scheme.ot_time_range_start.present? && pay_scheme.ot_time_range_end.present?

            # find ot hours worked
            ot_hours = 0
            normal_hours = hours_worked
            ot_start = pay_scheme.ot_time_range_start
            ot_end = pay_scheme.ot_time_range_end
            tl_start = self.date_time_in
            tl_end = self.date_time_out
            byebug
            # check if working time and ot time overlap
            if (tl_start..tl_end).overlaps?(ot_start..ot_end)
              byebug
              # check if working hours is entirely inside ot range
              if tl_start >= ot_start && ot_end >= tl_end
                ot_hours = hours_worked
                normal_hours = 0
                byebug
                # check if ot range is entirely inside working hours
              elsif ot_start >= tl_start && tl_end >= ot_end
                ot_hours = TimeDifference.between(ot_start, ot_end).in_hours
                normal_hours = TimeDifference.between(ot_start, tl_start).in_hours + TimeDifference.between(ot_end, tl_end).in_hours
                byebug
                # check if working_start_time is outside ot_hours_range && working_end_time is within ot_hours_range
              elsif tl_start.between?(ot_start, ot_end) == false && tl_end.between?(ot_start, ot_end) == true
                ot_hours = TimeDifference.between(ot_start, tl_end).in_hours
                normal_hours = TimeDifference.between(tl_start, ot_start).in_hours
                byebug
                # check if working_start_time is within ot_hours_range && working_end_time is outside ot_hours_range
              elsif tl_start.between?(ot_start, ot_end) == true && tl_end.between?(ot_start, ot_end) == false
                ot_hours = TimeDifference.between(tl_start, ot_end).in_hours
                normal_hours = TimeDifference.between(ot_end, tl_end).in_hours
                byebug
              end

              # else if according to specfied hours
            elsif pay_scheme.hours_per_day.present?
              byebug
              # find ot hours worked
              ot_hours = hours_worked - pay_scheme.hours_per_day
              if ot_hours <= 0
                ot_hours = 0
              end
              normal_hours = hours_worked - ot_hours
            end

            # see whether ot is multiplier or fixed
            # if multiplier
            if pay_scheme.ot_type.name == 'Multiplier'
              byebug
              shift_pay = normal_hours * hourly_normal_pay + ot_hours * (pay_scheme.ot_multiplier * hourly_normal_pay)
              # else if fixed
            elsif pay_scheme.ot_type.name != 'PerHr'
              byebug
              shift_pay = normal_hours * hourly_normal_pay + ot_hours * pay_scheme.pay_ot
            end
          end

        else
          # calc by hours_work * normal_pay
          byebug
          shift_pay = hours_worked * hourly_normal_pay
        end
      end
      self.pay = shift_pay
      puts "hours worked: #{hours_worked}"
      puts "hourly normal pay: #{hourly_normal_pay}"
      puts "shift_pay: #{shift_pay}"
    end

    def payment_scheme_is_hourly_type?
      self.payment_record_pay_scheme.hourly_type?
    end

    def public_holiday?(date)
      Holiday.public_holiday?(date)
    end
end
