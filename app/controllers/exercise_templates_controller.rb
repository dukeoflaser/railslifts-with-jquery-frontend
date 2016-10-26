class ExerciseTemplatesController < ApplicationController
  def show
    @exercise_template = ExerciseTemplate.find(params[:id])
    respond_to do |format|
      format.json { render json: @exercise_template}
    end
  end
end
