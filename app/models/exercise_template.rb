class ExerciseTemplate < ActiveRecord::Base
  has_and_belongs_to_many :workout_templates
end
