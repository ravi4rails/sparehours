class HomeController < ApplicationController

  def index
    @professionals = User.professionals
  end

end
