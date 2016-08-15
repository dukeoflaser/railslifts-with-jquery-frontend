class AddOwnerIdToExerciseTemplates < ActiveRecord::Migration
  def change
    add_column :exercise_templates, :owner_id, :integer
  end
end
