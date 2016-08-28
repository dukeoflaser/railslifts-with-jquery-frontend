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

    if params[:select_workout] || params[:add_workout]
      @program.workout_templates.build
      render 'new'
    elsif params[:remove_workout]
      @program.workout_templates.build
      @program.workout_templates.last.delete
      last_workout = @templates.keys.last
      @templates.delete(last_workout)
      render 'new'
    else
      if @program.valid?
        @program.owner_id = current_user.id

        params[:program][:workout_templates_attributes].each do |k, v|
            @program.workout_templates << WorkoutTemplate.find(v[:id])
        end

        @program.save
        current_user.programs << @program

        redirect_to program_path(@program)
      else
        @program.workout_templates.build
        render 'new'
      end
    end

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
