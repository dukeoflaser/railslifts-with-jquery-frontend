class ChangeExerciseStartingWeightColumnName < ActiveRecord::Migration
  def change
    rename_column :exercises, :weight, :weight
  end
end
