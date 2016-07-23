class WorkoutTemplate < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :exercise_templates
end
