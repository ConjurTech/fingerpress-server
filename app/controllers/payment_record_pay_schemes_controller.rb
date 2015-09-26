class PaymentRecordPaySchemesController < ApplicationController
  before_action :set_payment_record_pay_scheme, only: [:show, :edit, :update, :destroy]

  # GET /payment_record_pay_schemes
  # GET /payment_record_pay_schemes.json
  def index
    @payment_record_pay_schemes = PaymentRecordPayScheme.all
  end

  # GET /payment_record_pay_schemes/1
  # GET /payment_record_pay_schemes/1.json
  def show
  end

  # GET /payment_record_pay_schemes/new
  def new
    @payment_record_pay_scheme = PaymentRecordPayScheme.new
  end

  # GET /payment_record_pay_schemes/1/edit
  def edit
  end

  # POST /payment_record_pay_schemes
  # POST /payment_record_pay_schemes.json
  def create
    @payment_record_pay_scheme = PaymentRecordPayScheme.new(payment_record_pay_scheme_params)

    respond_to do |format|
      if @payment_record_pay_scheme.save
        format.html { redirect_to @payment_record_pay_scheme, notice: 'Payment record pay scheme was successfully created.' }
        format.json { render :show, status: :created, location: @payment_record_pay_scheme }
      else
        format.html { render :new }
        format.json { render json: @payment_record_pay_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_record_pay_schemes/1
  # PATCH/PUT /payment_record_pay_schemes/1.json
  def update
    respond_to do |format|
      if @payment_record_pay_scheme.update(payment_record_pay_scheme_params)
        format.html { redirect_to @payment_record_pay_scheme, notice: 'Payment record pay scheme was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_record_pay_scheme }
      else
        format.html { render :edit }
        format.json { render json: @payment_record_pay_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_record_pay_schemes/1
  # DELETE /payment_record_pay_schemes/1.json
  def destroy
    @payment_record_pay_scheme.destroy
    respond_to do |format|
      format.html { redirect_to payment_record_pay_schemes_url, notice: 'Payment record pay scheme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_record_pay_scheme
      @payment_record_pay_scheme = PaymentRecordPayScheme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_record_pay_scheme_params
      params[:payment_record_pay_scheme]
    end
end
