class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy
  #sign_in
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user
      # json_response "Signed In Successfuly" , true , {user: @user },:ok
      render json: {
               message: "Signed In Successfuly",
               is_success: true,
               data: {user: @user},

             }, status: :ok
    else
      # json_response "Unauthorized" , false , {},:unauthorized
      render json: {
               message: "Unauthorized",
               is_success: false,
               data: {},

             }, status: :unauthorized
    end
  end

  # log out
  def destroy
    sign_out @user
    @user.generate_new_authentication_token
    json_response "loge out", true, {}, :ok

    # render json: {
    #          message: "signed out successfully",
    #          is_success: true,
    #          data: {},

    #        }, status: :ok
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end

  def load_user
    @user = User.find_for_database_authentication email: sign_in_params[:email]
    if @user
      return @user
    else
      # json_response "cant get user" , false , {}, :failure
      render json: {
               message: "cant get user",
               is_success: false,
               data: {},

             }, status: :failure
    end
  end

  def valid_token
    @user = User.find_by authentication_token: request.headers["AUTH-TOKEN"]
  end
end
