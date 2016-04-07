class Api::V1::EmployeesController < Api::V1::BaseController
  before_action :set_employee_by_fingerprint, only: [:fingerprint_check_in, :fingerprint_check_out]
  before_action :set_employee, only: [:fingerprint_register]

  # GET api/v1/fingerprint_employees
  # GET api/v1/fingerprint_employees.json
  def fingerprint_employees
    @employees = Employee.all
  end

  # check in employee
  def fingerprint_check_in
    @employee.time_logs.create!(date_time_in: Time.at(params[:timestamp].to_i))
    render :show
  end

  # check out employee
  # Finds the timelog after the last valid timelog that does not have a date_time_out set yet and sets the checkout time on it.
  # If none is found, creates a new timelog and sets the checkout time on it.
  def fingerprint_check_out
    last_valid_timelog = @employee.time_logs.complete.order(date_time_out: :desc).first
    time_must_be_after = last_valid_timelog.try(:date_time_out) || Time.at(0) # for the first record

    timelog = @employee.time_logs.where('date_time_in > ?', time_must_be_after).where(date_time_out: nil).first
    timelog ||= @employee.time_logs.new
    timelog.date_time_out = Time.at(params[:timestamp].to_i)
    timelog.save!

    render :show
  end

  def fingerprint_register
    @employee.fingerprint_id = params[:fingerprint_id]
    @employee.save
    render :show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find_by(id: params[:employee_id])
  end

  # use fingerprint id and scanner uuid to set employee
  def set_employee_by_fingerprint
    @employee = Employee.find_or_initialize_by(fingerprint_id: params[:fingerprint_id])

    if @employee.new_record?
      @employee.pay_scheme = PayScheme.first
      @employee.name = "Unknown Employee"
      @employee.save!
    end

    @employee
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def employee_params
    params.require(:employee).permit(:fingerprint_id, :employee_id, :scanner_uuid)
  end
end
