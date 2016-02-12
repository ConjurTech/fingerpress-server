class ConfigController < ApplicationController
  before_action :set_config, only: [:edit, :update]
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
      if Workday.update(params[:workdays].keys,params[:workdays].values)
        format.html { redirect_to config_edit_path, notice: 'config was successfully updated.' }
        format.json { render :show, status: :ok, location: @config }
      else
        format.html { render :edit }
        format.json { render json: @config.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_config
    @workdays = Workday.all
    @holidays = Holiday.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def config_params
    params.require(:workdays).permit(workdays_attributes: [:id, :name, :start_time_seconds, :end_time_seconds, :start_time, :end_time, :enabled])
  end
end