class ChangeStartingWeightColumnNameInWorkoutTemplates < ActiveRecord::Migration
  def change
      rename_column :exercise_templates, :weight, :weight
  end
end
