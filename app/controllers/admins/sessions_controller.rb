class Admins::SessionsController < Devise::SessionsController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  protected

  def json_request?
    request.format.json?
  end
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
