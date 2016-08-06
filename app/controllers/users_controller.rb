class UsersController < ApplicationController
  def show
    redirect_to new_user_session_path if current_user.nil?
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
