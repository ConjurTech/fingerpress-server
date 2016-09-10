class Api::V1::FingerprintController < Api::V1::BaseController
  before_action :set_employee_by_id, only: [:register, :delete]
  before_action :set_employee_by_fingerprint, only: [:check_in, :check_out, :check_in_out]


  # check in / out employee
  def check_in_out
    if TimeLogConfig.first.check_in_time?(Time.at(params[:timestamp].to_i))
      @check_in = true
      check_in
    else
      @check_in = false
      check_out
    end
  end

  # Create time_log with check in time for employee
  def check_in
    unless @employee.present?
      render(json: {}, status: :unprocessable_entity) and return
    end
    check_in_time = Time.at(params[:timestamp].to_i)
    time_log = @employee.time_logs.create!(date_time_in: check_in_time) unless @employee.time_logs.where(date_time_in: (check_in_time - 10.minutes)..check_in_time).any?
    render json: time_log
  end

  # check out employee
  # Finds the timelog after the last valid timelog that does not have a date_time_out set yet and sets the checkout time on it.
  # If none is found, creates a new timelog and sets the checkout time on it.
  def check_out
    unless @employee.present?
      render(json: {}, status: :unprocessable_entity) and return
    end
    last_valid_timelog = @employee.time_logs.complete.order(date_time_out: :desc).first
    time_must_be_after = last_valid_timelog.try(:date_time_out) || Time.at(0) # for the first record
    check_out_time = Time.at(params[:timestamp].to_i)

    unless @employee.time_logs.where(date_time_out: (check_out_time - 10.minutes)..check_out_time).any?
      time_log = @employee.time_logs.where('date_time_in > ?', time_must_be_after).where(date_time_out: nil).first
      time_log ||= @employee.time_logs.new
      time_log.date_time_out = Time.at(check_out_time)
      time_log.save!
    end

    render json: time_log
  end

  def register
    @employee.update!(fingerprint_id: params[:fingerprint_id])
    render json: @employee
  end

  def delete
    unless @employee.present?
      render(json: {}, status: :unprocessable_entity) and return
    end
    employee = @employee.find_by(fingerprint_id: params[:fingerprint_id])
    employee.update_columns(fingerprint_id: nil)
    render json: @employee
  end

  def employees
    @employees = Employee.all.order("LOWER(name)")
    render json: @employees, scanner_uuid: params[:scanner_uuid]
  end

  private

  def set_employee_by_id
    @employee = Employee.find_by(id: params[:employee_id])
  end

  def set_employee_by_fingerprint
    # use fingerprint id and scanner uuid to find employee

    @employee = Employee.find_or_initialize_by(fingerprint_id: params[:fingerprint_id])

    if @employee.new_record?
      @employee.pay_scheme = PayScheme.first
      @employee.name = "Unknown Employee"
      @employee.save!
    end

    @employee
  end
end
