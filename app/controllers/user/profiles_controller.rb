class User::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit_profile
    @user = User.find(params[:id])
  end

  def update_profile
    @user = User.find(params[:user][:id])
    if params[:user][:password].empty?
      @user.update_without_password(user_params)
      redirect_to root_path, notice: "Profile updated successfully."
    else
      @user.update(user_params)
      redirect_to root_path, notice: "Profile updated successfully. You to login again."
    end
  end
  

  private

  def user_params
   params.require(:user).permit(:first_name, :last_name, :contact, :city, :state, :country, :account_type, :date_of_birth,
      :latitude, :longitude, :address, :proflie_image, :email, :password, :password_confirmation)
  end
end