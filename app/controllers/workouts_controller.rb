class WorkoutsController < ApplicationController

  def index
  end

  def show
  end

  def new
    unless params[:user_id].to_i == current_user.id
      redirect_to user_next_workout_path(current_user)
    end

    @workout = Workout.new
  end

  def created
  end

end
