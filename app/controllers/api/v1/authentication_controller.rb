class Api::V1::AuthenticationController < ApplicationController
  def authenticate
    result = JSON.parse($redis.get("users"))
    if result[permit_params[:username]]["password"] == permit_params[:password]
        token = encode_token({username: permit_params[:username]})
        render json: { status: true, message: "OK", token:token}, status: 200
    else
        render json: { status: false, message: "Authentication failure"}, status: 401
    end
  end

  def authenticate_token
    payload = decoded_token(params[:token])
    if check_existance(payload[0]["username"])
      render json: { status: true, message: "OK"}, status: 200
      return true
    else
      render json: { status: false, message: "Authentication failure"}, status: 401
    end
  end

private

  def permit_params
     params.except(:format, :home).permit(:username, :password)
  end

  def check_existance(username)
      check_empty_list
      if JSON.parse($redis.get("users")).key?(username)
        return true
      else
        return false
      end
  end

  def check_empty_list
    if $redis.get("users").nil?
      $redis.set("users",{})
    end
  end

end
