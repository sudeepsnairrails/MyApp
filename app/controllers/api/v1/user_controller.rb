class Api::V1::UserController < ApplicationController
  respond_to :json
  before_action :authenticate_token, only: [:index]

  def index
    check_empty_list
    respond_with JSON.parse($redis.get("users"))
  end

  def show
    check_empty_list
    if !JSON.parse($redis.get("users"))[permit_params[:username]].nil?
      respond_with JSON.parse($redis.get("users"))[permit_params[:username]]
    else
      render json: { status: false, message: "Empty list"}, status: 404
    end
  end

  def new
    new_user = User.new(permit_params)
  end

  def create
    new_user = User.new(permit_params)
    if new_user.valid?
      if check_existance(new_user.username)
        render json: { status: false, message: "User Exists"}, status: 409
      else
        Rails.cache.clear
        $redis.set("users", JSON.parse($redis.get("users")).merge!({new_user.username => {"username" => new_user.username, "password" => new_user.password}}).to_json)
        render json: { status: true, message: "User Created"}, status: 201
      end
    else
      render json: { status: false, message: "Invalid Attributes"}, status: 406
    end
  end

  def edit
    user = JSON.parse($redis.get("users"))[permit_params[:username]]
  end

  def update
    user = JSON.parse($redis.get("users"))
    if check_existance(permit_params[:username])
      user[permit_params[:username]]["password"] = permit_params[:password]
      $redis.set("users", user.to_json)
      render json: { status: true, message: "User Updated"}, status: 201
    else
      render json: { status: false, message: "User doesnot exists"}, status: 404
    end
  end

  def delete
    user = JSON.parse($redis.get("users"))[permit_params[:username]]
  end

  def destroy
    user = JSON.parse($redis.get("users"))
    if check_existance(permit_params[:username])
      user.delete(permit_params[:username])
      $redis.set("users", user.to_json)
      render json: { status: true, message: "User Deleted"}, status: 201
    else
      render json: { status: false, message: "User doesnot exists"}, status: 404
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
