# Class for the AuthenticateUser command, authenticates a user to the API
class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  # Generate token for the User
  # @return [String] an authentication token for the User
  def call
    JsonWebToken.encode(user_id: user.id, user_email: user.email) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user&.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
