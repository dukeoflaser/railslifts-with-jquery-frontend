class ExerciseController < ApplicationController

  def new
    @exercise = Exercise.create
  end

  def create
    @exercise = Exercise.create(exercise_params)
  end

  def exercise_params
    binding.pry
  end

end
