class PaymentRecordsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_payment_record, only: [:show, :edit, :update, :destroy]

  # GET /payment_records
  # GET /payment_records.json
  def index
    @payment_records = PaymentRecord.all.page(params[:page]).per(10)
  end

  # GET /payment_records/1
  # GET /payment_records/1.json
  def show
  end

  # GET /payment_records/new_pay_roll
  def new_pay_roll
    @pay_roll = PayRoll.new
  end

  # POST /payment_records/create_pay_roll
  def create_pay_roll
    @pay_roll = PayRoll.new(pay_roll_params)
    @pay_roll.save
    employees = Employee.where(id: pay_roll_params[:employee_ids])
    start_date = pay_roll_params[:start_date]
    end_date = pay_roll_params[:end_date]

    #build payment record params of each employee
    employees.each do |e|
      pay_slip = PaymentRecord.new(employee_id: e.id, start_date: start_date, end_date: end_date, pay_roll_id: @pay_roll.id)
      pay_slip.save
      employee_time_logs = pay_slip.employee.valid_time_logs_between(start_date.to_datetime, end_date.to_datetime)
      perm_time_logs = []
      employee_time_logs.each do |employee_time_log|
        # save a permanent copy of pay scheme in case it gets deleted in the future
        payment_record_pay_scheme = PaymentRecordPayScheme.new_from_pay_scheme(employee_time_log.pay_scheme)
        payment_record_pay_scheme.save
        # save a permanent copy of time log in case it gets deleted in the future
        perm_time_log = PaymentRecordTimeLog.new(date_time_in: employee_time_log.date_time_in,
                                 date_time_out: employee_time_log.date_time_out,
                                 workday: employee_time_log.workday?,
                                 public_holiday: employee_time_log.public_holiday?,
                                 ot_hours: employee_time_log.ot_hours,
                                 remarks: employee_time_log.remarks,
                                 public_holiday_name: employee_time_log.public_holiday_name,
                                 payment_record_pay_scheme: payment_record_pay_scheme,
                                 payment_record: pay_slip
        )
        perm_time_log.save
        perm_time_logs << perm_time_log
        # set the normal time log that user sees to point to this record
        employee_time_log.payment_record = pay_slip
        employee_time_log.save
      end
      pay_slip.payment_record_time_logs = perm_time_logs
      pay_slip.save
    end
    respond_to do |format|
      if @pay_roll.errors.blank?
        format.html { redirect_to @pay_roll, notice: 'Payment record was successfully created.' }
        format.json { render :show, status: :created, location: @payment_record }
      else
        format.html { render :new }
        format.json { render json: @payment_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /payment_records/new
  def new
    @payment_record = PaymentRecord.new
  end

  # GET /payment_records/1/edit
  def edit
  end

  # POST /payment_records
  # POST /payment_records.json
  def create
    @payment_record = PaymentRecord.new(payment_record_params)

    employee_time_logs = @payment_record.employee.valid_time_logs_between(payment_record_params[:start_date].to_datetime, payment_record_params[:end_date].to_datetime)
    employee_time_logs.each do |employee_time_log|
      # save a permanent copy of pay scheme in case it gets deleted in the future
      payment_record_pay_scheme = PaymentRecordPayScheme.new_from_pay_scheme(employee_time_log.pay_scheme)
      payment_record_pay_scheme.save
      # save a permanent copy of time log in case it gets deleted in the future
      PaymentRecordTimeLog.new(date_time_in: employee_time_log.date_time_in,
                               date_time_out: employee_time_log.date_time_out,
                               payment_record_pay_scheme: payment_record_pay_scheme,
                               payment_record: @payment_record
      ).save
      # set the normal time log that user sees to point to this record
      employee_time_log.payment_record = @payment_record
      employee_time_log.save
    end

    respond_to do |format|
      if @payment_record.save
        format.html { redirect_to edit_payment_record_path(@payment_record), notice: 'Payment record was successfully created.' }
        format.json { render :show, status: :created, location: @payment_record }
      else
        format.html { render :new }
        format.json { render json: @payment_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_records/1
  # PATCH/PUT /payment_records/1.json
  def update
    respond_to do |format|
      if @payment_record.update(payment_record_params)
        format.html { redirect_to @payment_record, notice: 'Payment record was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_record }
      else
        format.html { render :edit }
        format.json { render json: @payment_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_records/1
  # DELETE /payment_records/1.json
  def destroy
    @payment_record.destroy
    respond_to do |format|
      format.html { redirect_to payment_records_url, notice: 'Payment record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_payment_record
    @payment_record = PaymentRecord.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_record_params
    params.require(:payment_record).permit(:start_date, :end_date, :total_pay, :bonus, :paid_at, :employee_id, :paid)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pay_roll_params
    params.require(:pay_roll).permit(:start_date, :end_date, employee_ids: [])
  end
end
