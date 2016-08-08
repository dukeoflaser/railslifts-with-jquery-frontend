class ExerciseTemplatesController < ApplicationController

  def index
    if request.fullpath == my_exercise_templates_path
      @exercise_templates = current_user.exercise_templates
      @current_exercise_templates_link = exercise_templates_path
      @current_exercise_templates_text = 'View All Available Exercise Templates'
    else
      @exercise_templates = ExerciseTemplate.all
      @current_exercise_templates_link = my_exercise_templates_path
      @current_exercise_templates_text = 'View My Exercise Templates'
    end
  end

end
