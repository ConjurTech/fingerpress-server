class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :destroy_session

  before_action :authenticate_admin_from_token!

  private

  def authenticate_admin_from_token!
    admin_email = request.headers["HTTP_ADMIN_EMAIL"].presence
    admin = admin_email && Admin.find_by_email(admin_email)
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if admin && Devise.secure_compare(admin.authentication_token, request.headers["HTTP_AUTH_TOKEN"])
      sign_in admin, store: false
    else
      false
    end
  end

  def authenticate
    authenticate_admin_from_token! || render_unauthorized
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    if request.env['PATH_INFO'] != new_admin_session_path # to avoid redirect loop
      respond_to do |format|
        format.json { render json: 'Bad credentials', status: 401 }
      end
    end
  end

  def destroy_session
    request.session_options[:skip] = true
  end
end