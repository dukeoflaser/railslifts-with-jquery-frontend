class WorkoutTemplatesController < ApplicationController
  before_filter :modify_params, :only => [:create, :update]

  def index
    if request.fullpath == my_workout_templates_path
      values = [
        WorkoutTemplate.where('owner_id = ? AND standin IS NULL', current_user.id),
        workout_templates_path,
        'View All Workout Templates'
      ]
    else
      values = [
        WorkoutTemplate.where('standin IS NULL'),
        my_workout_templates_path,
        'View My Workout Templates'
      ]
    end
    @workout_templates = WorkoutTemplate.all
    @collection = values[0]
    @link = values[1]
    @text = values[2]

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @workout_templates }
    end
  end

  def show
    @workout_template = WorkoutTemplate.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @workout_template }
    end
  end

  def new
    @workout_template = WorkoutTemplate.new
  end

  def create
    @workout_template = WorkoutTemplate.new(workout_template_params)
    destroy_standins
    form_logic('new')
  end

  def edit
    @wt = WorkoutTemplate.find(params[:id])

    unless @wt.owner_id == current_user.id
      redirect_to workout_template_path(@wt)
    end

    destroy_standins
    @workout_template = standin_for(@wt)
    @workout_template.exercise_templates << @wt.exercise_templates

    @templates = get_exercise_template_attributes
    clear_and_build_exercise_templates
  end

  def update
    @workout_template = WorkoutTemplate.find(params[:id])
    @workout_template.name = workout_template_params[:name]
    @workout_template.description = workout_template_params[:description]

    unless workout_template_params[:exercise_templates_attributes].blank?
      @workout_template.exercise_templates_attributes = workout_template_params[:exercise_templates_attributes]
    end
    @workout_template.save(validate: false)

    form_logic('edit')
  end

  def destroy
    @workout_template = WorkoutTemplate.find(params[:id])
    @workout_template.delete
    redirect_to workout_templates_path
  end









  def workout_template_params
    params.require(:workout_template).permit(
      :name,
      :description,
      :exercise_templates_attributes => [
        :name,
        :reps,
        :weight,
        :rest
      ]
    )
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
      templates[key] = {
        name: et.name,
        reps: et.reps,
        weight: et.weight,
        rest: et.rest
      }
      key += 1
    end

    templates
  end

  def form_logic(action)
    if params[:workout_template][:exercise_templates_attributes]
      @templates = exercise_template_params
    end

    if params[:add_new_exercise] || params[:select_existing_exercise] || params[:add_exercise]
      add_exercise_to_template(action)
    elsif params[:remove_exercise]
      remove_exercise_from_template(action)
    elsif params[:create_workout]
      create_workout
    elsif params[:update_workout]
      update_workout
    end
  end

  def clear_and_build_exercise_templates
    @workout_template.exercise_templates.clear
    @workout_template.exercise_templates.build
  end

  def add_exercise_to_template(action)
    clear_and_build_exercise_templates
    @empty_values = {name: "", reps: "", weight: "", rest: ""}
    render action
  end

  def remove_exercise_from_template(action)
    clear_and_build_exercise_templates
    @workout_template.exercise_templates.last.delete
    @templates.delete(@templates.keys.last)
    @workout_template.errors.clear
    render action
  end

  def create_workout
    @workout_template.owner_id = current_user.id

    if @workout_template.valid?
      @workout_template.save
      redirect_to workout_template_path(@workout_template)
    else
      clear_and_build_exercise_templates
      render 'new'
    end
  end

  def update_workout

    unless @workout_template.errors.any? || !@workout_template.valid?
      @wt = WorkoutTemplate.find(@workout_template.standin)

      @wt.owner_id = current_user.id
      @wt.name = @workout_template.name
      @wt.description = @workout_template.description
      @wt.exercise_templates.clear
      @wt.exercise_templates_attributes = exercise_template_params

      alter_standin_name

      if !@wt.valid?
        @error = "The name '#{@wt.name}' is already in use. Please choose another name."
        restore_standin_name
        clear_and_build_exercise_templates
        render 'edit'
      else
        destroy_standins
        @wt.save
        redirect_to workout_template_path(@wt)
      end
    else
      clear_and_build_exercise_templates
      render 'edit'
    end
  end

  def standin_for(template)
    standin = template.dup
    standin.standin = template.id
    standin.save(validate: false)
    standin
  end

  def destroy_standins
    standins = WorkoutTemplate.where('standin IS NOT NULL')
    standins.each do |standin|
      standin.destroy
    end
  end

  def alter_standin_name
    @workout_template.name += "***"
    @workout_template.save
  end

  def restore_standin_name
    @workout_template.name.slice!("***")
    @workout_template.save
  end

end
