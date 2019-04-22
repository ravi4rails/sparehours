class User::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit_profile;end

  def edit_personal_info;end

  def edit_address_info;end

  def dashboard;end

  def update_profile
    if params[:user][:password].empty?
      @user.update_without_password(user_params)
      redirect_to root_path, notice: "Profile updated successfully."
    else
      @user.update(user_params)
      redirect_to root_path, notice: "Profile updated successfully. You to login again."
    end
  end

  def update_personal_info
    if @user.update(user_personal_info_params)
      redirect_to user_edit_personal_info_path, notice: "Your personal information has been updated successfully."
    else
      render :edit_personal_info
    end
  end

  def update_address_info
    if @user.update(user_address_info_params)
      redirect_to user_edit_address_info_path, notice: "Your address information has been updated successfully."
    else
      render :edit_address_info
    end
  end
  

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :contact, :city, :state, :country, :account_type, :date_of_birth,
        :latitude, :longitude, :address, :proflie_image, :email, :password, :password_confirmation)
    end

    def user_personal_info_params
      params.require(:user).permit(:first_name, :last_name, :contact, :date_of_birth, :proflie_image)
    end

    def user_address_info_params
      params.require(:user).permit(:address, :city, :state, :country, :latitude, :longitude)
    end
end