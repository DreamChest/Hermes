# Class for JWT handling
class JsonWebToken
  class << self
    # Encode a JWT token
    # @param payload payload for the token
    # @param exp expiration date for the token
    # @return [String] a JWT token
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    # Decode a JWT token
    # @param token token to decode
    # @return the decoded token
    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue StandardError
      nil
    end
  end
end
