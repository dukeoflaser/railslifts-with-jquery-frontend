class ProgramsController < ApplicationController

  def index
    if request.fullpath == my_programs_path
      values = [current_user.programs, programs_path, 'View All Programs', 'My Programs']
    else
      values = [Program.all, my_programs_path, 'View My Programs', 'Programs']
    end

    @programs = values[0]
    @collection = values[0]
    @link = values[1]
    @text = values[2]
    @title = values[3]

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @programs }
    end
  end

  def show
    @program = Program.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @program}
    end
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(program_params)
    @templates = template_params

    form_logic
  end

  def edit
    @program = Program.find(params[:id])
    redirect_to program_path(@program) if @program.owner_id != current_user.id

    @templates = get_workout_template_ids
    @program.workout_templates.clear.build
  end

  def update
    @program = Program.find(params[:id])
    @program.update(program_params)
    @templates = template_params

    form_logic
  end

  def destroy
    @program = Program.find(params[:id])
    @program.delete
    redirect_to my_programs_path
  end





  def program_params
    params.require(:program).permit(:name, :description)
  end

  def template_params
    params[:program][:workout_templates_attributes]
  end

  def get_workout_template_ids
    key = 0
    templates = {}

    @program.workout_templates.each do |wt|
      templates[key] = {id: wt.id}
      key += 1
    end

    templates
  end

  def select
    @program = Program.find(params[:id])
    current_user.select_program(@program)
    redirect_to user_next_workout_path(current_user)
  end

  def remove_workout_template
    @program.workout_templates.build
    @program.workout_templates.last.delete
    @templates.delete(@templates.keys.last)
  end

  def form_logic
    if params[:select_workout] || params[:add_workout]
      @program.workout_templates.build
      render 'new'
    elsif params[:remove_workout]
      remove_workout_template
      render 'new'
    else
      process_program
    end
  end

  def process_program
    if @program.valid?

      template_params.each do |k, v|
          @program.workout_templates << WorkoutTemplate.find(v[:id])
      end
      @program.update(owner_id: current_user.id)

      current_user.programs << @program
      redirect_to program_path(@program)
    else
      @program.workout_templates.build
      render 'new'
    end
  end

end
