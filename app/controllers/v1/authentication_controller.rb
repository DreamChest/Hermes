# API version 1
module V1
  # Authentication controller class (for API)
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    # Authenticate a user based on email and password
    def authenticate
      command = AuthenticateUser.call(params[:email], params[:password])

      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
  end
end
