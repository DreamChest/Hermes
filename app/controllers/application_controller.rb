# Main controller class
class ApplicationController < ActionController::API
  before_action :authenticate_request

  # Getter for current_user
  # @return the current user
  attr_reader :current_user

  # Render app and api versions
  def version
    render json: {
      app_version: Hermes::APP_VERSION,
      api_version: Hermes::API_VERSION
    }
  end

  private

  # Authenticate incoming requests
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
