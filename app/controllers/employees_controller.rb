class EmployeesController < ApplicationController
  skip_before_action :protect_from_forgery, only: [:check_in, :check_out]
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :register]
  before_action :set_employee_by_fingerprint, only: [:check_in, :check_out]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @time_logs = @employee.time_logs.complete.page(params[:page]).per(5)
    @hrs_logged = @time_logs.map{|tl| [tl.date_time_in.to_formatted_s(:short), TimeDifference.between(tl.date_time_in, tl.date_time_out).in_hours]}
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  def check_in
    @employee.time_logs.create!(date_time_in: Time.at(params[:timestamp].to_i))
    render :show
  end

  def register
    @employee.fingerprint_id = params[:fingerprint_id]
    @employee.save
    render :show
  end

  # Finds the timelog after the last valid timelog that does not have a date_time_out set yet and sets the checkout time on it.
  # If none is found, creates a new timelog and sets the checkout time on it.
  def check_out
    last_valid_timelog = @employee.time_logs.complete.order(date_time_out: :desc).first
    time_must_be_after = last_valid_timelog.try(:date_time_out) || Time.at(0) # for the first record

    timelog = @employee.time_logs.where('date_time_in > ?', time_must_be_after).where(date_time_out: nil).first
    timelog ||= @employee.time_logs.new
    timelog.date_time_out = Time.at(params[:timestamp].to_i)
    timelog.save!

    render :show
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find_by(id: params[:id])
  end

  def set_employee_by_fingerprint
    @employee = Employee.find_or_initialize_by(fingerprint_id: params[:id])

    if @employee.new_record?
      @employee.pay_scheme = PayScheme.first
      @employee.name = "Unknown Employee"
      @employee.save!
    end

    @employee
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def employee_params
    params.require(:employee).permit(:fingerprint_id, :name, :sex, :birthdate, :joindate, :leavedate, :bankdetails, :pay_scheme_id, :job)
  end
end
