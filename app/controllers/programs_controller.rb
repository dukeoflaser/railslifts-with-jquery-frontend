class ProgramsController < ApplicationController
  def index
    if request.fullpath == "/my_programs"
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
  end

  def new
  end

  def created
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
