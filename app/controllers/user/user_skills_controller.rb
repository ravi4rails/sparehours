class User::UserSkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_skill

  def update
    @user_skill.update(is_primary: params[:set])
    @skill_name = @user_skill.skill.name
    if @user_skill.is_primary
      redirect_to user_skills_path, flash: { success: "#{@skill_name} has been added to your primary skills" }
    else
      redirect_to user_skills_path, flash: { success: "#{@skill_name} has been removed from primary skills" }
    end

  end

  def destroy
    @user_skill.destroy
    redirect_to user_skills_path, flash: { success: 'Skill has been removed from your account.' } 
  end

  private

    def set_user_skill
      @user_skill = UserSkill.find(params[:id])
    end

end
