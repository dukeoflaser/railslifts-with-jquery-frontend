class ChangeWeightColumnInExerciseTemplates < ActiveRecord::Migration
  def change
    change_column :exercise_templates, :starting_weight, :integer
  end
end
