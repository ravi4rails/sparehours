class HomeController < ApplicationController

  def index
    @professionals = User.professionals
  end

  def pricing;end

end
