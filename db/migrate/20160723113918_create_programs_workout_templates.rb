class CreateProgramsWorkoutTemplates < ActiveRecord::Migration
  def change
    create_table :programs_workout_templates do |t|
      t.integer :program_id
      t.integer :workout_template_id
    end
  end
end
