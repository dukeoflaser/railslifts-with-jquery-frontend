class AddNameToWorkoutTemplates < ActiveRecord::Migration
  def change
    add_column :workout_templates, :name, :string
  end
end
