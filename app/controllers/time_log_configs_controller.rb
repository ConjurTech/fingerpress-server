class TimeLogConfigsController < ApplicationController
  before_action :set_time_log_config, only: [:edit, :update]
  before_action :authenticate_admin!

  # GET /config/show_api_key
  def show_api_key
  end

  # GET /configs/edit
  def edit
  end

  # PATCH/PUT /configs/
  def update
    respond_to do |format|
      if @time_log_config.update(config_params)
        format.html { redirect_to time_log_config_edit_path, notice: 'Config was successfully updated.' }
        # format.json { render :show, status: :ok, location: @config }
      else
        format.html { render :edit }
        format.json { render json: time_log_config.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_time_log_config
    @time_log_config = TimeLogConfig.first
    @workdays = Workday.all
    @holidays = Holiday.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def config_params
    params.require(:time_log_config).permit(:start_time_lower_tolerance, :start_time_upper_tolerance, :end_time_lower_tolerance, :end_time_upper_tolerance,
                                             :auto_adjust_end_time, :auto_adjust_start_time,
                                             workdays_attributes: [:id, :name, :start_time_seconds, :end_time_seconds, :start_time, :end_time, :enabled])
  end
end