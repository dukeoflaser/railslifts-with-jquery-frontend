class DropExercisesWorkoutsTable < ActiveRecord::Migration
  def change
    drop_table :exercises_workouts
  end
end
