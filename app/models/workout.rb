class Workout < ActiveRecord::Base
  has_and_belongs_to_many :exercises
  belongs_to :user
  accepts_nested_attributes_for :exercises

  # after_create do |workout|
  #   current_user.update_workout_cycle_index
  # end
end
