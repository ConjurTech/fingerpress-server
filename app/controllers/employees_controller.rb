class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @time_logs = @employee.time_logs
    @hrs_logged = @time_logs.map{|tl| [tl.date_time_in, TimeDifference.between(tl.date_time_in, tl.date_time_out).in_hours]}
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  def check_in
    time_log = @employee.time_logs.create(date_time_in: Time.current)
    if time_log.errors.empty?
      render :show
    else
      render json: { errors: time_log.errors.full_messages }, status: :bad_request
    end
  end

  def check_out
    time_log = @employee.time_logs.where(date_time_out: nil).order(date_time_in: :desc).first
    time_log ||= @employee.time_logs.new
    time_log.date_time_out = Time.current
    if time_log.save
      render :show
    else
      render json: { errors: time_log.errors.full_messages }, status: :bad_request
    end
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
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :sex, :birthdate, :joindate, :leavedate, :bankdetails, :pay_scheme_id, :job)
    end
end
