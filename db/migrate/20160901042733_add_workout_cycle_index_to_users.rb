class AddWorkoutCycleIndexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :workout_cycle_index, :integer, :default => false
  end
end
