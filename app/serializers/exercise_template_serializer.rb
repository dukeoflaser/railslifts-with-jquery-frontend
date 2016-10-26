class ExerciseTemplateSerializer < ActiveModel::Serializer
  attributes :id, :name, :reps, :weight, :rest, :owner_id, :default
  # has_many :workout_templates
end
