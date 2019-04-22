class User::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit_profile;end

  def edit_personal_info;end

  def edit_address_info;end

  def dashboard;end

  def manage_skills
    @skills = Skill.order(:name)
  end

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
  
  def update_skills
    if params[:skills][:skill_remove].present?
      id_param_arr = params[:skills][:skill_remove].map {|i| i.to_i}
      if @user.skills.ids.uniq != id_param_arr
        diff_arr = @user.skills.ids - id_param_arr
        @user.user_skills.where('skill_id IN (?)', diff_arr).destroy_all
      end
    else
      @user.user_skills.destroy_all
    end
    if params[:skills][:skill_add].present?
      params[:skills][:skill_add].each do |skill_id|
        @user.user_skills.create(skill_id: skill_id)
      end
    end
    redirect_to user_skills_path, flash: { success: 'Your skills has been updated' }
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