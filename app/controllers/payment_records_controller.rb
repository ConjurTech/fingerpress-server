class PaymentRecordsController < ApplicationController
  before_action :set_payment_record, only: [:show, :edit, :update, :destroy]

  # GET /payment_records
  # GET /payment_records.json
  def index
    @payment_records = PaymentRecord.all
  end

  # GET /payment_records/1
  # GET /payment_records/1.json
  def show
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
    employee_time_logs = @payment_record.employee.time_logs_between(payment_record_params[:start_date].to_datetime, payment_record_params[:end_date].to_datetime)
    employee_time_logs.each do |employee_time_log|
      payment_record_pay_scheme = PaymentRecordPayScheme.new(pay_type: employee_time_log.pay_scheme.pay_type,
                                                             pay: employee_time_log.pay_scheme.pay,
                                                             pay_ot: employee_time_log.pay_scheme.pay_ot,
                                                             pay_public_holiday: employee_time_log.pay_scheme.pay_public_holiday,
                                                             name: employee_time_log.pay_scheme.name,
                                                             ot_multiplier: employee_time_log.pay_scheme.ot_multiplier,
                                                             ot_time_range_start: employee_time_log.pay_scheme.ot_time_range_start,
                                                             ot_time_range_end: employee_time_log.pay_scheme.ot_time_range_end,
                                                             public_holiday_multiplier: employee_time_log.pay_scheme.public_holiday_multiplier,
                                                             pay_weekend: employee_time_log.pay_scheme.pay_weekend,
                                                             weekend_multiplier: employee_time_log.pay_scheme.weekend_multiplier,
                                                             ot_type: employee_time_log.pay_scheme.ot_type,
                                                             public_holiday_type: employee_time_log.pay_scheme.public_holiday_type,
                                                             weekend_type: employee_time_log.pay_scheme.weekend_type)

      payment_record_pay_scheme.save
      PaymentRecordTimeLog.new(date_time_in: employee_time_log.date_time_in,
                               date_time_out: employee_time_log.date_time_out,
                               payment_record_pay_scheme: payment_record_pay_scheme,
                               payment_record: @payment_record
                               ).save
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
end
