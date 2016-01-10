class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  # This is our new function that comes before Devise's one
  before_filter :authenticate

  private

  def authenticate_admin_from_token!
    admin_email = request.headers["HTTP_ADMIN_EMAIL"].presence
    admin = admin_email && Admin.find_by_email(admin_email)
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if admin && Devise.secure_compare(admin.authentication_token, request.headers["HTTP_AUTHENTICATION_TOKEN"])
      sign_in admin, store: false
    else
      false
    end
  end

  def authenticate
    admin_signed_in? || authenticate_admin_from_token! || devise_controller? || render_unauthorized
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    if request.env['PATH_INFO'] != new_admin_session_path # to avoid redirect loop
      respond_to do |format|
        format.html { redirect_to new_admin_session_path, notice: 'Please sign in' }
        format.json { render json: 'Bad credentials', status: 401 }
      end
    end
  end
end
