class TimeLogsController < ApplicationController
  skip_before_action :protect_from_forgery
  before_action :set_time_log, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /time_logs
  # GET /time_logs.json
  def index
    @time_logs = TimeLog.all.order(created_at: :desc).page(params[:page]).per(10)
    @invalid_time_logs = TimeLog.where(time_log_is_valid: false, created_at: Time.at(0)...1.days.ago).order(created_at: :desc).page(params[:page])
  end

  def delete_all_invalid
    @invalid_time_logs = TimeLog.where(time_log_is_valid: false, created_at: Time.at(0)...1.days.ago).order(created_at: :desc).page(params[:page])
    @invalid_time_logs.destroy_all
    respond_to do |format|
      format.html { redirect_to time_logs_url, notice: 'Invalid Time log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /time_logs/1
  # GET /time_logs/1.json
  def show
  end

  # GET /time_logs/new
  def new
    @time_log = TimeLog.new
  end

  # GET /time_logs/1/edit
  def edit
  end

  # POST /time_logs
  # POST /time_logs.json
  def create
    @time_log = TimeLog.new(time_log_params)
    
    respond_to do |format|
      if @time_log.save
        format.html { redirect_to @time_log, notice: 'Time log was successfully created.' }
        format.json { render :show, status: :created, location: @time_log }
      else
        format.html { render :new }
        format.json { render json: @time_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_logs/1
  # PATCH/PUT /time_logs/1.json
  def update
    respond_to do |format|
      if @time_log.update(time_log_params)
        format.html { redirect_to @time_log, notice: 'Time log was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_log }
      else
        format.html { render :edit }
        format.json { render json: @time_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_logs/1
  # DELETE /time_logs/1.json
  def destroy
    @time_log.destroy
    respond_to do |format|
      format.html { redirect_to time_logs_url, notice: 'Time log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_log
      @time_log = TimeLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_log_params
      params.require(:time_log).permit(:date_time_in, :date_time_out, :employee_id, :pay_scheme_id, :time_in, :date_in, :date_out, :time_out)
    end
end
