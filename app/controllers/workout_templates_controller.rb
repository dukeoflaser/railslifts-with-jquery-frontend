class WorkoutTemplatesController < ApplicationController
  before_filter :modify_params, :only => [:create, :update]

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

    if params[:workout_template][:exercise_templates_attributes]
      @templates = exercise_template_params
    end


    if params[:add_new_exercise] || params[:select_existing_exercise] || params[:add_exercise]
      @workout_template.exercise_templates.build
      render 'new'
    elsif params[:remove_exercise]
      @workout_template.exercise_templates.build
      @workout_template.exercise_templates.last.delete
      last_exercise = @templates.keys.last
      @templates.delete(last_exercise)
      render 'new'
    elsif params[:create_workout]
      if @workout_template.valid?
        @workout_template.owner_id = current_user.id
        @workout_template.save

        params[:workout_template][:exercise_templates_attributes].each do |k, v|
          @workout_template.exercise_templates << ExerciseTemplate.find_or_create_by(name: v[:name])
        end


        # binding.pry
        redirect_to workout_template_path(@workout_template)
      else
        @workout_template.exercise_templates.build
        render 'new'
      end
    end

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
    params.require(:workout_template).require(:exercise_templates_attributes).permit!
  end

  def id_to_attributes(v)
    attributes = {}
    template = ExerciseTemplate.find(v[:id])
    attributes[:name] = template.name
    attributes[:reps] = template.reps
    attributes[:starting_weight] = template.starting_weight
    attributes[:rest] = template.rest
    attributes
  end

  def modify_params
    atts = params[:workout_template][:exercise_templates_attributes]

    unless atts.nil?
      params[:workout_template][:exercise_templates_attributes].each do |k, v|
        v = id_to_attributes(v) if v[:id]
        params[:workout_template][:exercise_templates_attributes][k] = v
      end
    end
  end

end
