class ProgramsController < ApplicationController
  def index
    if request.fullpath == my_programs_path
      @programs = current_user.programs
      @current_programs_link = programs_path
      @current_programs_text = 'View All Programs'
    else
      @programs = Program.all
      @current_programs_link = my_programs_path
      @current_programs_text = 'View My Programs'
    end
  end

  def show
    @program = Program.find(params[:id])
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(program_params)
    @templates = params[:program][:workout_templates_attributes]

    if params[:add_workout]
      @program.workout_templates.build
    elsif params[:remove_workout]
      @program.workout_templates.build
      @program.workout_templates.last.delete
      last_workout = @templates.keys.last
      @templates.delete(last_workout)
    else
      @program.owner_id = current_user.id
      @program.workout_templates << WorkoutTemplate.find(params[:program][:workout_templates])
      @program.save
      redirect_to program_path(@program)
    end

    render 'new'
  end

  def edit
  end

  def update
  end

  def destroy
    @program = Program.find(params[:id])
    @program.delete
    redirect_to my_programs_path
  end

  def program_params
    params.require(:program).permit(:name, :description)
  end

end
