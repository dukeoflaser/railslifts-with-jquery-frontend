class CreateWorkoutTemplates < ActiveRecord::Migration
  def change
    create_table :workout_templates do |t|
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
