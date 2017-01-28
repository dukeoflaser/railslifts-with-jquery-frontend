class CreateExerciseTemplates < ActiveRecord::Migration
  def change
    create_table :exercise_templates do |t|
      t.string :name
      t.string :reps
      t.integer :weight
      t.integer :rest

      t.timestamps null: false
    end
  end
end
