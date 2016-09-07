class WorkoutTemplatesController < ApplicationController
  before_filter :modify_params, :only => [:create, :update]

  def index
    if request.fullpath == my_workout_templates_path
      values = [
        WorkoutTemplate.where('owner_id = ?', current_user.id),
        workout_templates_path,
        'View All Available Workout Templates'
      ]
    else
      values = [
        WorkoutTemplate.all,
        my_workout_templates_path,
        'View My Workout Templates'
      ]
    end

    @collection = values[0]
    @link = values[1]
    @text = values[2]
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
      @workout_template.owner_id = current_user.id
      @workout_template.exercise_templates_attributes=(exercise_template_params)

      if @workout_template.valid?
        @workout_template.save
        redirect_to workout_template_path(@workout_template)
      else
        @workout_template.exercise_templates.clear
        @workout_template.exercise_templates.build
        render 'new'
      end
    end
  end

  def edit
    @workout_template = WorkoutTemplate.find(params[:id])

    unless @workout_template.owner_id == current_user.id
      redirect_to workout_template_path(@workout_template)
    end
    @templates = get_exercise_template_attributes
    @workout_template.exercise_templates.clear
    @workout_template.exercise_templates.build
  end

  def update
    @workout_template = WorkoutTemplate.find(params[:id])
    @workout_template.update(workout_template_params)

    if params[:workout_template][:exercise_templates_attributes]
      @templates = exercise_template_params
    end


    if params[:add_new_exercise] || params[:select_existing_exercise] || params[:add_exercise]
      @workout_template.exercise_templates.clear
      @workout_template.exercise_templates.build
      render 'edit'
    elsif params[:remove_exercise]
      @workout_template.exercise_templates.clear
      @workout_template.exercise_templates.build
      last_exercise = @templates.keys.last
      @templates.delete(last_exercise)
      render 'edit'
    elsif params[:update_workout]
      @workout_template.owner_id = current_user.id
      @workout_template.exercise_templates_attributes=(exercise_template_params)

      unless @workout_template.errors.any? || !@workout_template.valid?
        @workout_template.save
        redirect_to workout_template_path(@workout_template)
      else
        @workout_template.exercise_templates.clear
        @workout_template.exercise_templates.build
        render 'edit'
      end
    end
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
    attributes[:weight] = template.weight
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

  def get_exercise_template_attributes
    key = 0
    templates = {}
    @workout_template.exercise_templates.each do |et|
      templates[key] = {name: et.name,
                            reps: et.reps,
                            weight: et.weight,
                            rest: et.rest
      }
      key += 1
    end

    templates
  end

end
