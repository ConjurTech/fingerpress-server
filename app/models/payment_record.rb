class PaymentRecord < ActiveRecord::Base
  belongs_to :employee, -> { with_deleted }
  has_many :payment_record_time_logs, dependent: :destroy
  has_many :time_logs, dependent: :nullify
  accepts_nested_attributes_for :employee, reject_if: :all_blank, allow_destroy: false
  before_save :set_paid_at, :calculate_pay

  def paid?
    self.paid_at.present?
  end

  def set_paid_at
    self.paid_at = Time.zone.now
  end

  def calculate_pay
    # get_employee
    # Get timelogs and their payschemes
    time_logs = self.payment_record_time_logs
    # For each timelog:
    total_pay = time_logs.map { |time_log|
      # for every timelog, get hrs worked, get payscheme, calculate pay based on payscheme
      pay_scheme = time_log.payment_record_pay_scheme
      shift_pay = 0.0

      # If hrly pay
      if pay_scheme.pay_type.name == 'Hourly'
        # Total Hours worked = endtime-starttime
        hours_worked = TimeDifference.between(time_log.date_time_in, time_log.date_time_out).in_hours
        hourly_normal_pay = pay_scheme.pay

        # Check if start date is weekend
        if (time_log.date_time_in.saturday? || time_log.date_time_in.sunday?) && pay_scheme.weekend_type.name != 'None'

          if pay_scheme.weekend_type.name == 'PerHour'
            # calc by hours_work * weekend_pay
            shift_pay = hours_worked * pay_scheme.pay_weekend
          elsif pay_scheme.weekend_type.name == 'Multiplier'
            # calc by hours_work * weekend_pay_multiplier * normal_pay
            shift_pay = hours_worked * pay_scheme.weekend_multiplier * hourly_normal_pay
          end
          # Check if start date is public holiday
        elsif is_public_holiday(time_log.date_time_in) && pay_scheme.public_holiday_type.name != 'None'
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
            # see whether its range or according to specified hours
            # if there is a range specified
            if pay_scheme.ot_time_range_start.present? && pay_scheme.ot_time_range_end.present?
              # find ot hours worked
              ot_hours = 0
              normal_hours = 0
              ot_start = pay_scheme.ot_time_range_start
              ot_end = pay_scheme.ot_time_range_end
              tl_start = time_log.date_time_in
              tl_end = time_log.date_time_out

              # check if working time and ot time overlap
              if (tl_start..tl_end).overlaps?(ot_start..ot_end)
                # check if working hours is entirely inside ot range
                if tl_start >= ot_start && ot_end >= tl_end
                  ot_hours = hours_worked
                  normal_hours = 0

                  # check if ot range is entirely inside working hours
                elsif ot_start >= tl_start && tl_end >= ot_end
                  ot_hours = TimeDifference.between(ot_start, ot_end).in_hours
                  normal_hours = TimeDifference.between(ot_start, tl_start).in_hours + TimeDifference.between(ot_end, tl_end).in_hours

                  # check if working_start_time is outside ot_hours_range && working_end_time is within ot_hours_range
                elsif tl_start.between?(ot_start, ot_end) == false && tl_end.between?(ot_start, ot_end) == true
                  ot_hours = TimeDifference.between(ot_start, tl_end).in_hours
                  normal_hours = TimeDifference.between(tl_start, ot_start).in_hours

                  # check if working_start_time is within ot_hours_range && working_end_time is outside ot_hours_range
                elsif tl_start.between?(ot_start, ot_end) == true && tl_end.between?(ot_start, ot_end) == false
                  ot_hours = TimeDifference.between(tl_start, ot_end).in_hours
                  normal_hours = TimeDifference.between(ot_end, tl_end).in_hours
                end

                # else if according to specfied hours
              elsif pay_scheme.hours_per_day.present?
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
                shift_pay = normal_hours * normal_pay + ot_hours * (pay_scheme.ot_multiplier * hourly_normal_pay)
                # else if fixed
              elsif pay_scheme.ot_type.name != 'PerHr'
                shift_pay = normal_hours * normal_pay + ot_hours * pay_scheme.pay_ot
              end
            end

          else
            # calc by hours_work * normal_pay
            shift_pay = hours_worked * hourly_normal_pay
          end
        end

      end
      shift_pay
    }.reduce(:+)
    self.total_pay = total_pay
  end

  def is_public_holiday(date)
    false
  end
end
