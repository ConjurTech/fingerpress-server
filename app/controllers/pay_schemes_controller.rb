class PaySchemesController < ApplicationController
  before_action :set_pay_scheme, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /pay_schemes
  # GET /pay_schemes.json
  def index
    @pay_schemes = PayScheme.all
  end

  # GET /pay_schemes/1
  # GET /pay_schemes/1.json
  def show
  end

  # GET /pay_schemes/new
  def new
    @pay_scheme = PayScheme.new
  end

  # GET /pay_schemes/1/edit
  def edit
  end

  # POST /pay_schemes
  # POST /pay_schemes.json
  def create
    @pay_scheme = PayScheme.new(pay_scheme_params)

    respond_to do |format|
      if @pay_scheme.save
        format.html { redirect_to @pay_scheme, notice: 'Pay scheme was successfully created.' }
        format.json { render :show, status: :created, location: @pay_scheme }
      else
        format.html { render :new }
        format.json { render json: @pay_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_schemes/1
  # PATCH/PUT /pay_schemes/1.json
  def update
    respond_to do |format|
      if @pay_scheme.update(pay_scheme_params)
        format.html { redirect_to @pay_scheme, notice: 'Pay scheme was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_scheme }
      else
        format.html { render :edit }
        format.json { render json: @pay_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_schemes/1
  # DELETE /pay_schemes/1.json
  def destroy
    @pay_scheme.destroy
    respond_to do |format|
      format.html { redirect_to pay_schemes_url, notice: 'Pay scheme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_scheme
      @pay_scheme = PayScheme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_scheme_params
      params.require(:pay_scheme).permit(:pay_type_id, :pay, :pay_ot, :pay_public_holiday, :name, :ot_type_id)
    end
end
