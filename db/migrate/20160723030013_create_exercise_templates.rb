class CreateExerciseTemplates < ActiveRecord::Migration
  def change
    create_table :exercise_templates do |t|
      t.string :name
      t.string :reps
      t.string :starting_weight
      t.integer :rest

      t.timestamps null: false
    end
  end
end
