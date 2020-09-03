class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  def encode_token(payload)
    JWT.encode(payload, 'my_secret')
  end
  def decoded_token(token)
    begin
     JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
    rescue
      return false
    end
  end
end
