class WorkoutTemplatesController < ApplicationController

  def index
    if request.fullpath == my_workout_templates_path
      @workout_templates = current_user.workout_templates
      @current_workout_templates_link = workout_templates_path
      @current_workout_templates_text = 'View All Available Workout Templates'
    else
      @workout_templates = WorkoutTemplate.all
      @current_workout_templates_link = my_workout_templates_path
      @current_workout_templates_text = 'View My Workout Templates'
    end
  end

end
