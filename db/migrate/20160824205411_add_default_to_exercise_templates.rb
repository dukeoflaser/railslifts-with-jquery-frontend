class AddDefaultToExerciseTemplates < ActiveRecord::Migration
  def change
    add_column :exercise_templates, :default, :boolean, :default => false
  end
end
