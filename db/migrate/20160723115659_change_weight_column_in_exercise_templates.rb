class ChangeWeightColumnInExerciseTemplates < ActiveRecord::Migration
  def change
    change_column :exercise_templates, :weight, :integer
  end
end
