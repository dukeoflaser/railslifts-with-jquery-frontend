class CreateExerciseTemplatesWorkouTemplates < ActiveRecord::Migration
  def change
    create_table :exercise_templates_workout_templates do |t|
      t.integer :exercise_template_id
      t.integer :workout_template_id
    end
  end
end
