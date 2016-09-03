class ExerciseTemplatesController < ApplicationController

  def index
    if request.fullpath == my_exercise_templates_path
      @exercise_templates = ExerciseTemplate.where('owner_id = ?', current_user.id)
      @current_exercise_templates_link = exercise_templates_path
      @current_exercise_templates_text = 'View All Available Exercise Templates'
    else
      @exercise_templates = ExerciseTemplate.all
      @current_exercise_templates_link = my_exercise_templates_path
      @current_exercise_templates_text = 'View My Exercise Templates'
    end
  end

  def show
    @exercise_template = ExerciseTemplate.find(params[:id])
  end

  def new
    @exercise_template = ExerciseTemplate.new
  end

  def create
    @exercise_template = ExerciseTemplate.create(exercise_template_params)
    @exercise_template.update(owner_id: current_user.id)

    if @exercise_template.valid?
      redirect_to exercise_template_path(@exercise_template)
    else
      render 'new'
    end

  end

  def edit
    @exercise_template = ExerciseTemplate.find(params[:id])
  end

  def update
    @exercise_template = ExerciseTemplate.find(params[:id])
    @exercise_template.update(exercise_template_params)
    redirect_to exercise_template_path(@exercise_template)
  end

  def destroy
    @exercise_template = ExerciseTemplate.find(params[:id])
    @exercise_template.delete
    redirect_to exercise_templates_path
  end

  def exercise_template_params
    params.require(:exercise_template).permit(:name, :reps, :weight, :rest)
  end

end
