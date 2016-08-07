class HomeController < ApplicationController
  def index
    redirect_to profile_path unless current_user.nil?
  end
end
