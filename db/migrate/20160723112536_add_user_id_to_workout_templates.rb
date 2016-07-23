class AddUserIdToWorkoutTemplates < ActiveRecord::Migration
  def change
    add_column :workout_templates, :user_id, :integer
  end
end
