class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :reps
      t.integer :weight
      t.integer :rest

      t.timestamps null: false
    end
  end
end
