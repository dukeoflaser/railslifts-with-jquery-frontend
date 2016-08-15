class WorkoutTemplatesController < ApplicationController

  def index
    if request.fullpath == my_workout_templates_path
      @workout_templates = WorkoutTemplate.where('owner_id = ?', current_user.id)
      @current_workout_templates_link = workout_templates_path
      @current_workout_templates_text = 'View All Available Workout Templates'
    else
      @workout_templates = WorkoutTemplate.all
      @current_workout_templates_link = my_workout_templates_path
      @current_workout_templates_text = 'View My Workout Templates'
    end
  end

  def show
    @workout_template = WorkoutTemplate.find(params[:id])
  end

  def new
    @workout_template = WorkoutTemplate.new

  end

  def create
    @workout_template = WorkoutTemplate.new(workout_template_params)
    @templates = params[:workout_template][:exercise_templates_attributes]

    if params[:add_new_exercise]
      @workout_template.exercise_templates.build
    else
      @workout_template.exercise_templates_attributes=exercise_template_params
      @workout_template.update(owner_id: current_user.id)
      redirect_to workout_template_path(@workout_template)
    end

    render 'new'
  end

  def edit
    @workout_template = WorkoutTemplate.find(params[:id])
  end

  def update
    @workout_template = WorkoutTemplate.find(params[:id])
    @workout_template.update(workout_template_params)
    redirect_to workout_template_path(@workout_template)
  end

  def destroy
    @workout_template = WorkoutTemplate.find(params[:id])
    @workout_template.delete
    redirect_to workout_templates_path
  end





  def workout_template_params
    params.require(:workout_template).permit(:name, :description)
  end

  def exercise_template_params
    params.require(:workout_template).require(:exercise_templates_attributes)
  end
end
