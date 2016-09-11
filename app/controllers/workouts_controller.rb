class WorkoutsController < ApplicationController

  def index
    verify_current_user
    @workouts = current_user.workouts
  end

  def new
    verify_current_user
    @workout = Workout.new

    unless current_user.current_program.nil?
      @workout_template = current_user.next_workout

      collection.each do |x|
        @workout.exercises.build(
          name: x.name,
          reps: x.reps,
          weight: x.weight,
          rest: x.rest
        )
      end
    else
      @workout_template = nil
    end
  end

  def create
    @workout = Workout.create(workout_params)

    if @workout.valid?
      @workout.update(user: current_user)
      current_user.update_workout_cycle_index

      redirect_to root_path
    else
      @workout_template = current_user.next_workout
      render 'new'
    end
  end

  def workout_params
    params.require(:workout).permit(
      :name,
      :exercises_attributes => [
        :name,
        :reps,
        :weight,
        :rest
      ]
    )
  end

  def verify_current_user
    unless params[:user_id].to_i == current_user.id
      redirect_to user_workout_history_path(current_user)
    end
  end

  def collection
    unless current_user.workouts.where(name: @workout_template.name).blank?
      workouts = current_user.workouts.select do |w|
        w.name == @workout_template.name
      end

      workouts.last.exercises
    else
      @workout_template.exercise_templates
    end
  end

end
