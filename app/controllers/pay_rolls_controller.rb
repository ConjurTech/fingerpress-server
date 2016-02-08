class PayRollsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_pay_roll, only: [:show, :edit, :update, :destroy, :mark_all_paid]

  # GET /pay_rolls
  # GET /pay_rolls.json
  def index
    @pay_rolls = PayRoll.all
  end

  # GET /pay_rolls/1
  # GET /pay_rolls/1.json
  def show
    @payment_records = @pay_roll.payment_records.page(params[:page]).per(10)
  end

  # GET /pay_rolls/new
  def new
    @pay_roll = PayRoll.new
  end

  # GET /pay_rolls/1/edit
  # def edit
  # end

  # POST /pay_rolls
  # POST /pay_rolls.json
  def create
    @pay_roll = PayRoll.new(pay_roll_params)

    respond_to do |format|
      if @pay_roll.save
        format.html { redirect_to @pay_roll, notice: 'Pay roll was successfully created.' }
        format.json { render :show, status: :created, location: @pay_roll }
      else
        format.html { render :new }
        format.json { render json: @pay_roll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_rolls/1
  # PATCH/PUT /pay_rolls/1.json
  def update
    respond_to do |format|
      if @pay_roll.update(pay_roll_params)
        format.html { redirect_to @pay_roll, notice: 'Pay roll was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_roll }
      else
        format.html { render :edit }
        format.json { render json: @pay_roll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_rolls/1
  # DELETE /pay_rolls/1.json
  def destroy
    @pay_roll.destroy
    respond_to do |format|
      format.html { redirect_to pay_rolls_url, notice: 'Pay roll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mark_all_paid
    @pay_roll.mark_all_paid
    respond_to do |format|
      format.html { redirect_to pay_rolls_url, notice: 'Pay roll was successfully updated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_roll
      @pay_roll = PayRoll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_roll_params
      params.require(:pay_roll).permit(:start_date, :end_date, employee_ids: [])
    end
end
