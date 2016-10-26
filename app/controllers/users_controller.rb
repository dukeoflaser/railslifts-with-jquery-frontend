class UsersController < ApplicationController
  def show
    redirect_to new_user_session_path if current_user.nil?
    @last_workout = current_user.workouts.last
    @user = current_user
    @user_count = User.all.count
  end

  def leaderboard
    @leaderboard = User.leaderboard
    render 'leaderboard'
  end

  def data
    @user = User.find(params[:id])
    respond_to do |format|
      format.json { render json: @user }
    end
  end
end
