class AddDescriptionToWorkoutTemplates < ActiveRecord::Migration
  def change
    add_column :workout_templates, :description, :string
  end
end
