class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :destroy_session

  before_action :authenticate_admin_from_token!

  private

  def authenticate_admin_from_token!
    # This method automatically extracts Authorization: Token xxx header and put it in token
    authenticate_or_request_with_http_token do |token, options|
      admin = Admin.find_by_authentication_token(token)
      # Notice how we use Devise.secure_compare to compare the token
      # in the database with the token given in the params, mitigating
      # timing attacks.
      if admin && Devise.secure_compare(admin.authentication_token, token)
        sign_in admin, store: false
      end
    end
  end

  def authenticate
    authenticate_admin_from_token!
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  protected
  # override rails method to return json response
  def request_http_token_authentication(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render :json => {:error => "HTTP Token: Access denied."}, :status => :unauthorized
  end
end