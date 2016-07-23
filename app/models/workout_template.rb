class WorkoutTemplate < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_and_belongs_to_many :programs
  has_many :exercise_templates
end
