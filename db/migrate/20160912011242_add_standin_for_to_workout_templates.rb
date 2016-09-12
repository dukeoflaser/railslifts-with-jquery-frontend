class AddStandinForToWorkoutTemplates < ActiveRecord::Migration
  def change
    add_column :workout_templates, :standin, :integer
  end
end
